import 'package:toktok/domain/entities/video_post.dart';

class PexelVideoModel {
    final int id;
    final int width;
    final int height;
    final String url;
    final String image;
    final dynamic fullRes;
    final List<dynamic> tags;
    final int duration;
    final User user;
    final List<VideoFile> videoFiles;
    final List<VideoPicture> videoPictures;

    PexelVideoModel({
        required this.id,
        required this.width,
        required this.height,
        required this.url,
        required this.image,
        required this.fullRes,
        required this.tags,
        required this.duration,
        required this.user,
        required this.videoFiles,
        required this.videoPictures,
    });

    factory PexelVideoModel.fromJson(Map<String, dynamic> json) => PexelVideoModel(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        image: json["image"],
        fullRes: json["full_res"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        duration: json["duration"],
        user: User.fromJson(json["user"]),
        videoFiles: List<VideoFile>.from(json["video_files"].map((x) => VideoFile.fromJson(x))),
        videoPictures: List<VideoPicture>.from(json["video_pictures"].map((x) => VideoPicture.fromJson(x))),
    );

    VideoPost toVideoPostEntity() {
      String videoLink = url;
      if (videoFiles.isNotEmpty) {
        videoLink = videoFiles.first.link;
      }
      return VideoPost(
        videoUrl: Uri.parse(videoLink),
        caption: '${user.name} - ${tags.join(', ')}',
        image: image // ahora pasa la url real
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "image": image,
        "full_res": fullRes,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "duration": duration,
        "user": user.toJson(),
        "video_files": List<dynamic>.from(videoFiles.map((x) => x.toJson())),
        "video_pictures": List<dynamic>.from(videoPictures.map((x) => x.toJson())),
    };
}

class User {
    final int id;
    final String name;
    final String url;

    User({
        required this.id,
        required this.name,
        required this.url,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
    };
}

class VideoFile {
    final int id;
    final String quality;
    final String fileType;
    final int width;
    final int height;
    final double fps;
    final String link;

    VideoFile({
        required this.id,
        required this.quality,
        required this.fileType,
        required this.width,
        required this.height,
        required this.fps,
        required this.link,
    });

    factory VideoFile.fromJson(Map<String, dynamic> json) => VideoFile(
        id: json["id"],
        quality: json["quality"],
        fileType: json["file_type"],
        width: json["width"],
        height: json["height"],
        fps: json["fps"]?.toDouble(),
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quality": quality,
        "file_type": fileType,
        "width": width,
        "height": height,
        "fps": fps,
        "link": link,
    };
}

class VideoPicture {
    final int id;
    final String picture;
    final int nr;

    VideoPicture({
        required this.id,
        required this.picture,
        required this.nr,
    });

    factory VideoPicture.fromJson(Map<String, dynamic> json) => VideoPicture(
        id: json["id"],
        picture: json["picture"],
        nr: json["nr"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "nr": nr,
    };
}

