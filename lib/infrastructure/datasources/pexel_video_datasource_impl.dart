
import 'dart:convert';

import 'package:toktok/domain/datasources/video_post_datasource.dart';
import 'package:toktok/domain/entities/video_post.dart';
import 'package:http/http.dart' as http;
import 'package:toktok/infrastructure/models/pexel_video_model.dart';

class PexelVideoDatasourceImpl implements VideoPostDataSource {
  final String _apiKey = 'w6xuC1d3218WP9wr5OKf6ev3kb8O7LVmbIYbIUW83A86syd2zlFozfiK';
  final List<VideoPost> _newVideos = [];
  final int _perPage = 15;

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    final String query = 'trending';
    final String orientation = 'portrait';
    final String size = 'medium';

    final Uri url = Uri.https(
      'api.pexels.com',
      'videos/search',
      {
        'per_page': _perPage.toString(), 
        'page': page.toString(), 
        'query': query,
        'orientation': orientation,
        'size': size
      }
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': _apiKey,
        }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> videosJson = data['videos'] ?? [];
        for (final videoJson in videosJson) {
          final pexelVideoModel = PexelVideoModel.fromJson(videoJson);
          _newVideos.add(pexelVideoModel.toVideoPostEntity());
        }
      }
      return _newVideos;
    } catch (e) {
      rethrow;
    }
  }
}
