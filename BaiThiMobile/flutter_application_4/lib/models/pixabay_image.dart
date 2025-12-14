class PixabayImage {
  final int id;
  final String previewURL;
  final String webformatURL;
  final String largeImageURL;
  final String tags;
  final String user;
  final int likes;
  final int views;

  PixabayImage({
    required this.id,
    required this.previewURL,
    required this.webformatURL,
    required this.largeImageURL,
    required this.tags,
    required this.user,
    required this.likes,
    required this.views,
  });

  factory PixabayImage.fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      id: json['id'] as int,
      previewURL: json['previewURL'] as String,
      webformatURL: json['webformatURL'] as String,
      largeImageURL: json['largeImageURL'] as String? ?? json['webformatURL'] as String,
      tags: json['tags'] as String? ?? '',
      user: json['user'] as String? ?? '',
      likes: json['likes'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
    );
  }
}
