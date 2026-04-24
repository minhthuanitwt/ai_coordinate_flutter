import '../../core/models/my_page_balance.dart';
import '../../core/models/my_page_image_item.dart';
import '../../core/models/my_page_profile.dart';
import '../../core/models/my_page_stats.dart';

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
