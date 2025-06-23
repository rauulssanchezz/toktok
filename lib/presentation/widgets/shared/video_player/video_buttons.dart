import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktok/config/helpers/human_formats.dart';
import 'package:toktok/domain/entities/video_post.dart';

class VideoButtons extends StatelessWidget {
  final VideoPost video;

  const VideoButtons({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: _CustomIconButton(value: 0, imageUrl: video.image)
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final String? imageUrl;
  final Color color = Colors.white;

  const _CustomIconButton({
    required this.value,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageUrl != null && imageUrl!.isNotEmpty
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.play_circle_outlined, color: color, size: 30),
              ),
            )
          : Icon(Icons.play_circle_outlined, color: color, size: 30),
        if (value > 0)
          Text(HumanFormats.humanReadbleNumber(value.toDouble()))
      ],
    );
  }
}