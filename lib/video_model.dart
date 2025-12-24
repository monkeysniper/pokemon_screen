class VideoModel {
  final int id;
  final String url;
  final String image;
  final String user;

  VideoModel({
    required this.id,
    required this.url,
    required this.image,
    required this.user,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      url: json['video_files'][0]['link'],
      image: json['image'],
      user: json['user']['name'],
    );
  }
}
