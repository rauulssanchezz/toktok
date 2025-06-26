
import 'package:toktok/domain/datasources/video_post_datasource.dart';
import 'package:toktok/domain/entities/video_post.dart';
import 'package:toktok/domain/repositories/video_post_repository.dart';

class VideoPostRepositoryImpl implements VideoPostRepository {
  final VideoPostDataSource videosDataSource;

  VideoPostRepositoryImpl({
    required this.videosDataSource
  });

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page, String search) {
    try {
      return videosDataSource.getTrendingVideosByPage(page, search);
    } catch (e) {
      rethrow;
    }
  }

}
