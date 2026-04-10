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
  }) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const HomeRepositoryException('supabase_not_configured');
    }

    final response = await service.client
        .from('generated_images')
        .select(
          'id, user_id, image_url, prompt, caption, posted_at, view_count',
        )
        .eq('is_posted', true)
        .not('posted_at', 'is', null)
        .order('posted_at', ascending: false)
        .range(offset, offset + limit - 1);

    final rows = (response as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList();

    final userIds = rows
        .map((row) => row['user_id'] as String?)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList();

    final profiles = await _loadProfiles(userIds);

    return rows
        .map((row) => _mapFeedItem(row, profiles))
        .where((item) => item.imageUrl.isNotEmpty)
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
