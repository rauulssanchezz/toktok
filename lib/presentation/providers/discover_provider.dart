import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/video_post.dart';
import 'package:toktok/infrastructure/repositories/video_post_repository_impl.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostRepositoryImpl videosRepository;

  bool initialLoading = true;
  List<VideoPost> videos = [];
  int _currentPage = 1;
  String? errorMessage;
  String _currentSearch = '';

  DiscoverProvider({
    required this.videosRepository
  });

  Future<void> loadNextPage({String search = ''}) async {
    if (search != _currentSearch) {
      _currentSearch = search;
      _currentPage = 1;
      videos.clear();
      initialLoading = true;
    }
    try {
      final newVideos = await videosRepository.getTrendingVideosByPage(_currentPage, _currentSearch);
      errorMessage = null;
      if (_currentPage == 1) {
        videos = newVideos;
      } else {
        videos.addAll(newVideos);
      }
      _currentPage++;
    } catch (e) {
      errorMessage = 'No se encuentran resultados en este momento.';
      if (_currentPage == 1) videos = [];
    }
    initialLoading = false;
    notifyListeners();
  }
}