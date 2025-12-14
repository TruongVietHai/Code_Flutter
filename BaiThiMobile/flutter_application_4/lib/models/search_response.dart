import 'pixabay_image.dart';

class SearchResponse {
  final int total;
  final int totalHits;
  final List<PixabayImage> hits;

  SearchResponse({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final hitsJson = json['hits'] as List<dynamic>? ?? [];
    final images = hitsJson
        .map((item) => PixabayImage.fromJson(item as Map<String, dynamic>))
        .toList();

    return SearchResponse(
      total: json['total'] as int? ?? 0,
      totalHits: json['totalHits'] as int? ?? 0,
      hits: images,
    );
  }
}
