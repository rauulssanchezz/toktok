import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/video_post.dart';
import 'package:toktok/infrastructure/repositories/video_post_repository_impl.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostRepositoryImpl videosRepository;

  bool initialLoading = true;
  List<VideoPost> videos = [];
  
  int _currentPage = 1;
  String? errorMessage;

  DiscoverProvider({
    required this.videosRepository
  });
  
  Future<void> loadNextPage() async {
    List<VideoPost> newVideos;
    try {
      newVideos = await videosRepository.getTrendingVideosByPage(_currentPage);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'No se encuentran resultados en este momento.';
      newVideos = [];
    }
    _currentPage++;

    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners();
  }
}