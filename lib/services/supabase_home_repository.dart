import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/home_banner_item.dart';
import '../core/models/home_feed_item.dart';
import '../domain/repository/home_repository.dart';
import 'supabase_service.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return SupabaseHomeRepository();
});

class SupabaseHomeRepository implements HomeRepository {
  @override
  Future<List<HomeBannerItem>> listHomeBanners() async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const HomeRepositoryException('supabase_not_configured');
    }

    final now = DateTime.now();
    final response = await service.client
        .from('banners')
        .select(
          'id, image_url, link_url, alt, display_start_at, display_end_at, '
          'status, display_order',
        )
        .eq('status', 'published')
        .order('display_order', ascending: true);

    final rows = response as List<dynamic>;
    return rows
        .map((row) => Map<String, dynamic>.from(row as Map))
        .where((row) => _isBannerActive(row, now))
        .map(_mapBanner)
        .where((banner) => banner.imageUrl.isNotEmpty)
        .toList();
  }

  @override
  Future<List<HomeFeedItem>> listHomeFeedItems({
    int limit = 20,
    int offset = 0,
    HomeFeedSort sort = HomeFeedSort.newest,
    String? viewerUserId,
  }) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const HomeRepositoryException('supabase_not_configured');
    }

    switch (sort) {
      case HomeFeedSort.newest:
        return _listNewest(limit: limit, offset: offset);
      case HomeFeedSort.recommended:
        return _listRecommended(limit: limit, offset: offset);
      case HomeFeedSort.following:
        return _listFollowing(
          limit: limit,
          offset: offset,
          viewerUserId: viewerUserId,
        );
    }
  }

  Future<List<HomeFeedItem>> _listNewest({
    required int limit,
    required int offset,
  }) async {
    final response = await SupabaseService.instance.client
        .from('generated_images')
        .select('id, user_id, image_url, prompt, caption, posted_at, view_count')
        .eq('is_posted', true)
        .not('posted_at', 'is', null)
        .order('posted_at', ascending: false)
        .range(offset, offset + limit - 1);

    final rows = _castRows(response);
    return _buildFeedItems(rows: rows);
  }

  Future<List<HomeFeedItem>> _listFollowing({
    required int limit,
    required int offset,
    required String? viewerUserId,
  }) async {
    final userId = viewerUserId?.trim();
    if (userId == null || userId.isEmpty) {
      return const [];
    }

    final followsResponse = await SupabaseService.instance.client
        .from('follows')
        .select('followee_id')
        .eq('follower_id', userId);

    final followees = (followsResponse as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .map((row) => row['followee_id'] as String?)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList();

    if (followees.isEmpty) {
      return const [];
    }

    final response = await SupabaseService.instance.client
        .from('generated_images')
        .select('id, user_id, image_url, prompt, caption, posted_at, view_count')
        .eq('is_posted', true)
        .not('posted_at', 'is', null)
        .inFilter('user_id', followees)
        .order('posted_at', ascending: false)
        .range(offset, offset + limit - 1);

    final rows = _castRows(response);
    return _buildFeedItems(rows: rows);
  }

  Future<List<HomeFeedItem>> _listRecommended({
    required int limit,
    required int offset,
  }) async {
    final now = DateTime.now().toUtc();
    final jstNow = now.add(const Duration(hours: 9));
    final currentWeekday = jstNow.weekday % 7; // Sunday = 0
    final lastSundayJst = DateTime.utc(
      jstNow.year,
      jstNow.month,
      jstNow.day,
    ).subtract(Duration(days: currentWeekday + 7));
    final lastSaturdayEndJst = lastSundayJst
        .add(const Duration(days: 6))
        .add(const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999));
    final lastWeekStartUtc = lastSundayJst.subtract(const Duration(hours: 9));
    final lastWeekEndUtc = lastSaturdayEndJst.subtract(const Duration(hours: 9));

    final response = await SupabaseService.instance.client
        .from('generated_images')
        .select('id, user_id, image_url, prompt, caption, posted_at, view_count')
        .eq('is_posted', true)
        .not('posted_at', 'is', null)
        .gte('posted_at', lastWeekStartUtc.toIso8601String())
        .lte('posted_at', lastWeekEndUtc.toIso8601String())
        .order('posted_at', ascending: false)
        .limit(1000);

    final rows = _castRows(response);
    if (rows.isEmpty) {
      return const [];
    }

    final postIds = rows
        .map((row) => row['id'] as String?)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toList();
    final likeCounts = await _loadLikeCounts(
      postIds: postIds,
      fromUtc: lastWeekStartUtc,
      toUtc: lastWeekEndUtc,
    );

    final sortedRows = rows
        .where((row) => (likeCounts[row['id'] as String? ?? ''] ?? 0) > 0)
        .toList()
      ..sort((a, b) {
        final idA = a['id'] as String? ?? '';
        final idB = b['id'] as String? ?? '';
        final likeA = likeCounts[idA] ?? 0;
        final likeB = likeCounts[idB] ?? 0;
        if (likeA != likeB) {
          return likeB.compareTo(likeA);
        }
        final postedAtA =
            DateTime.tryParse(a['posted_at'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final postedAtB =
            DateTime.tryParse(b['posted_at'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return postedAtB.compareTo(postedAtA);
      });

    if (offset >= sortedRows.length) {
      return const [];
    }
    final end = (offset + limit).clamp(0, sortedRows.length).toInt();
    final pageRows = sortedRows.sublist(offset, end);

    return _buildFeedItems(rows: pageRows, likeCounts: likeCounts);
  }

  Future<Map<String, int>> _loadLikeCounts({
    required List<String> postIds,
    DateTime? fromUtc,
    DateTime? toUtc,
  }) async {
    if (postIds.isEmpty) {
      return const {};
    }

    var query = SupabaseService.instance.client
        .from('likes')
        .select('image_id, created_at')
        .inFilter('image_id', postIds);

    if (fromUtc != null) {
      query = query.gte('created_at', fromUtc.toIso8601String());
    }
    if (toUtc != null) {
      query = query.lte('created_at', toUtc.toIso8601String());
    }

    final response = await query;
    final rows = (response as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList();

    final counts = <String, int>{};
    for (final row in rows) {
      final imageId = row['image_id'] as String?;
      if (imageId == null || imageId.isEmpty) {
        continue;
      }
      counts[imageId] = (counts[imageId] ?? 0) + 1;
    }
    return counts;
  }

  Future<List<HomeFeedItem>> _buildFeedItems({
    required List<Map<String, dynamic>> rows,
    Map<String, int>? likeCounts,
  }) async {
    final userIds = rows
        .map((row) => row['user_id'] as String?)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList();

    final profiles = await _loadProfiles(userIds);
    return rows
        .map(
          (row) => _mapFeedItem(
            row,
            profiles,
            likeCount: likeCounts?[row['id'] as String? ?? ''],
          ),
        )
        .where((item) => item.imageUrl.isNotEmpty)
        .toList();
  }

  List<Map<String, dynamic>> _castRows(dynamic response) {
    return (response as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList();
  }

  Future<Map<String, _ProfileSummary>> _loadProfiles(
    List<String> userIds,
  ) async {
    if (userIds.isEmpty) {
      return const {};
    }

    final response = await SupabaseService.instance.client
        .from('profiles')
        .select('user_id, nickname, avatar_url')
        .inFilter('user_id', userIds);

    final rows = response as List<dynamic>;
    return {
      for (final row in rows.map(
        (row) => Map<String, dynamic>.from(row as Map),
      ))
        if ((row['user_id'] as String?) != null)
          row['user_id'] as String: _ProfileSummary(
            nickname: row['nickname'] as String?,
            avatarUrl: row['avatar_url'] as String?,
          ),
    };
  }

  HomeBannerItem _mapBanner(Map<String, dynamic> row) {
    return HomeBannerItem(
      id: row['id'] as String? ?? '',
      imageUrl: row['image_url'] as String? ?? '',
      alt: row['alt'] as String? ?? '',
      linkUrl: row['link_url'] as String?,
    );
  }

  HomeFeedItem _mapFeedItem(
    Map<String, dynamic> row,
    Map<String, _ProfileSummary> profiles,
    {int? likeCount}
  ) {
    final userId = row['user_id'] as String?;
    final profile = userId == null ? null : profiles[userId];

    return HomeFeedItem(
      id: row['id'] as String? ?? '',
      imageUrl: row['image_url'] as String? ?? '',
      postedAt:
          DateTime.tryParse(row['posted_at'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      prompt: row['prompt'] as String?,
      caption: row['caption'] as String?,
      userId: userId,
      creatorName: profile?.nickname,
      creatorAvatarUrl: profile?.avatarUrl,
      likeCount: likeCount,
      viewCount: row['view_count'] as int?,
    );
  }

  bool _isBannerActive(Map<String, dynamic> row, DateTime now) {
    final displayStart = DateTime.tryParse(
      row['display_start_at'] as String? ?? '',
    );
    final displayEnd = DateTime.tryParse(
      row['display_end_at'] as String? ?? '',
    );

    if (displayStart != null && displayStart.isAfter(now)) {
      return false;
    }
    if (displayEnd != null && !displayEnd.isAfter(now)) {
      return false;
    }
    return true;
  }
}

class HomeRepositoryException implements Exception {
  const HomeRepositoryException(this.code);

  final String code;
}

class _ProfileSummary {
  const _ProfileSummary({this.nickname, this.avatarUrl});

  final String? nickname;
  final String? avatarUrl;
}
