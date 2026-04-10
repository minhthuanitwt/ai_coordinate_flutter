import '../../core/models/home_banner_item.dart';
import '../../core/models/home_feed_item.dart';

abstract class HomeRepository {
  Future<List<HomeBannerItem>> listHomeBanners();

  Future<List<HomeFeedItem>> listHomeFeedItems({
    int limit = 20,
    int offset = 0,
  });
}
