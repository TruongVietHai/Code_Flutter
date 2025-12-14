import 'package:flutter/material.dart';

import '../models/pixabay_image.dart';

class ImageDetailScreen extends StatefulWidget {
  final PixabayImage image;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const ImageDetailScreen({
    super.key,
    required this.image,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _handleToggleFavorite() {
    widget.onToggleFavorite(); // cập nhật danh sách yêu thích ở ngoài
    setState(() {
      _isFavorite = !_isFavorite; // cập nhật icon trên màn chi tiết
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.image;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết ảnh #${image.id}'),
        actions: [
          IconButton(
            onPressed: _handleToggleFavorite,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'image_${image.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image.largeImageURL,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                image.tags,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text('Tác giả: ${image.user}'),
              const SizedBox(height: 8),
              Text('Likes: ${image.likes}  •  Views: ${image.views}'),
            ],
          ),
        ),
      ),
    );
  }
}
