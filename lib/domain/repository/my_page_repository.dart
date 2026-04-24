import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/models/my_page_balance.dart';
import '../../core/models/my_page_image_item.dart';
import '../../core/models/my_page_profile.dart';
import '../../core/models/my_page_stats.dart';
import '../../services/supabase_service.dart';
import '../failures/my_page_repository_failure.dart';

abstract class MyPageRepository {
  Future<MyPageProfile> getMyProfile({required String userId});

  Future<MyPageStats> getMyStats({required String userId});

  Future<MyPageBalance> getMyBalance({required String userId});

  Future<List<MyPageImageItem>> listMyImages({
    required String userId,
    int limit = 20,
    int offset = 0,
  });
}

final myPageRepositoryProvider = Provider<MyPageRepository>((ref) {
  return SupabaseMyPageRepository();
});

class SupabaseMyPageRepository implements MyPageRepository {
  @override
  Future<MyPageProfile> getMyProfile({required String userId}) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const MyPageRepositoryFailure('supabase_not_configured');
    }

    try {
      final response = await service.client
          .from('profiles')
          .select('user_id, nickname, bio, avatar_url, subscription_plan')
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) {
        return MyPageProfile(userId: userId);
      }

      final row = Map<String, dynamic>.from(response as Map);
      return MyPageProfile(
        userId: row['user_id'] as String? ?? userId,
        nickname: row['nickname'] as String?,
        bio: row['bio'] as String?,
        avatarUrl: row['avatar_url'] as String?,
        subscriptionPlan: row['subscription_plan'] as String?,
      );
    } catch (_) {
      throw const MyPageRepositoryFailure('unknown_error');
    }
  }

  @override
  Future<MyPageStats> getMyStats({required String userId}) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const MyPageRepositoryFailure('supabase_not_configured');
    }

    try {
      final generatedCount = await _countGeneratedImages(userId);
      final postedCount = await _countPostedImages(userId);
      final likeCount = await _countLikesForPostedImages(userId);
      final viewCount = await _sumViewsForPostedImages(userId);
      final followCounts = await _fetchFollowCounts(userId);

      return MyPageStats(
        generatedCount: generatedCount,
        generatedCountPublic: true,
        postedCount: postedCount,
        likeCount: likeCount,
        viewCount: viewCount,
        followerCount: followCounts.followerCount,
        followingCount: followCounts.followingCount,
      );
    } catch (_) {
      throw const MyPageRepositoryFailure('unknown_error');
    }
  }

  @override
  Future<MyPageBalance> getMyBalance({required String userId}) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const MyPageRepositoryFailure('supabase_not_configured');
    }

    try {
      final response = await service.client
          .from('user_credits')
          .select('balance')
          .eq('user_id', userId)
          .maybeSingle();
      final row = response == null
          ? const <String, dynamic>{}
          : Map<String, dynamic>.from(response as Map);
      final total = (row['balance'] as num?)?.toInt() ?? 0;
      return MyPageBalance(
        total: total,
        regular: total,
        paid: 0,
        unlimitedBonus: 0,
        periodLimited: 0,
      );
    } catch (_) {
      throw const MyPageRepositoryFailure('unknown_error');
    }
  }

  @override
  Future<List<MyPageImageItem>> listMyImages({
    required String userId,
    int limit = 20,
    int offset = 0,
  }) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const MyPageRepositoryFailure('supabase_not_configured');
    }

    try {
      final response = await service.client
          .from('generated_images')
          .select(
            'id, image_url, prompt, caption, is_posted, created_at, posted_at',
          )
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      final rows = (response as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

      return rows
          .map(
            (row) => MyPageImageItem(
              id: row['id'] as String? ?? '',
              imageUrl: row['image_url'] as String? ?? '',
              prompt: row['prompt'] as String?,
              caption: row['caption'] as String?,
              isPosted: row['is_posted'] as bool? ?? false,
              createdAt: DateTime.tryParse(row['created_at'] as String? ?? ''),
              postedAt: DateTime.tryParse(row['posted_at'] as String? ?? ''),
            ),
          )
          .where((item) => item.id.isNotEmpty && item.imageUrl.isNotEmpty)
          .toList();
    } catch (_) {
      throw const MyPageRepositoryFailure('unknown_error');
    }
  }

  Future<int> _countGeneratedImages(String userId) async {
    final response = await SupabaseService.instance.client
        .from('generated_images')
        .select('id')
        .eq('user_id', userId);
    return (response as List<dynamic>).length;
  }

  Future<int> _countPostedImages(String userId) async {
    final response = await SupabaseService.instance.client
        .from('generated_images')
        .select('id')
        .eq('user_id', userId)
        .eq('is_posted', true);
    return (response as List<dynamic>).length;
  }

  Future<int> _countLikesForPostedImages(String userId) async {
    final postedImages = await SupabaseService.instance.client
        .from('generated_images')
        .select('id')
        .eq('user_id', userId)
        .eq('is_posted', true);
    final postedImageIds = (postedImages as List<dynamic>)
        .map((item) => Map<String, dynamic>.from(item as Map))
        .map((row) => row['id'] as String?)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toList();

    if (postedImageIds.isEmpty) {
      return 0;
    }

    final likes = await SupabaseService.instance.client
        .from('likes')
        .select('id')
        .inFilter('image_id', postedImageIds);
    return (likes as List<dynamic>).length;
  }

  Future<int> _sumViewsForPostedImages(String userId) async {
    final response = await SupabaseService.instance.client
        .from('generated_images')
        .select('view_count')
        .eq('user_id', userId)
        .eq('is_posted', true);
    final rows = (response as List<dynamic>)
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
    var total = 0;
    for (final row in rows) {
      total += (row['view_count'] as num?)?.toInt() ?? 0;
    }
    return total;
  }

  Future<_FollowCounts> _fetchFollowCounts(String userId) async {
    try {
      final response = await SupabaseService.instance.client
          .rpc('get_follow_counts', params: {'p_user_id': userId})
          .maybeSingle();
      if (response == null) {
        return const _FollowCounts(followerCount: 0, followingCount: 0);
      }
      final row = Map<String, dynamic>.from(response as Map);
      return _FollowCounts(
        followerCount: (row['follower_count'] as num?)?.toInt() ?? 0,
        followingCount: (row['following_count'] as num?)?.toInt() ?? 0,
      );
    } catch (_) {
      return const _FollowCounts(followerCount: 0, followingCount: 0);
    }
  }
}

class _FollowCounts {
  const _FollowCounts({
    required this.followerCount,
    required this.followingCount,
  });

  final int followerCount;
  final int followingCount;
}
