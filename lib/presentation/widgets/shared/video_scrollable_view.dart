import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktok/domain/entities/video_post.dart';
import 'package:toktok/presentation/providers/discover_provider.dart';
import 'package:toktok/presentation/widgets/shared/video_player/video_buttons.dart';
import 'package:toktok/presentation/widgets/video/full_screen_player.dart';

class VideoScrollableView extends StatefulWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({
    super.key,
    required this.videos
  });

  @override
  State<VideoScrollableView> createState() => _VideoScrollableViewState();
}

class _VideoScrollableViewState extends State<VideoScrollableView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.videos.length,
      onPageChanged: (index) {
        if (index == widget.videos.length - 5) {
          final provider = Provider.of<DiscoverProvider>(context, listen: false);
          provider.loadNextPage();
        }
      },
      itemBuilder: (context, index) {
        final VideoPost videoPost = widget.videos[index];

        return Stack(
          children: [
            SizedBox.expand(
              child: FullScreenPlayer(
                caption: videoPost.caption,
                videoUrl: videoPost.videoUrl,
              )
            ),

            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(video: videoPost,)
            ),
          ],
        );
      },
    );
  }
}