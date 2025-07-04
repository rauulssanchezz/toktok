
import 'package:toktok/domain/entities/video_post.dart';

abstract class VideoPostDataSource {
  Future<List<VideoPost>> getTrendingVideosByPage(int page, String search);

  Future<List<VideoPost>> getFavoriteVideosByUser(String userId);
}
