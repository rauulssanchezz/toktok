class VideoPost {
  final String caption;
  final Uri videoUrl;
  final int likes;
  final int views;
  final String image; // ahora es String para la url
  
  VideoPost({
    required this.caption, 
    required this.videoUrl, 
    required this.image,
    this.likes = 0, 
    this.views = 0
  });
}