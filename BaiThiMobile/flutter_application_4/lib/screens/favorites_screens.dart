import 'package:flutter/material.dart';

import '../models/pixabay_image.dart';
import 'image_detail_screens.dart';

class FavoritesScreen extends StatelessWidget {
  final List<PixabayImage> favorites;
  final VoidCallback onBack;
  final bool Function(PixabayImage) isFavorite;
  final void Function(PixabayImage) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onBack,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 6;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text('Ảnh yêu thích'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('Bạn chưa yêu thích ảnh nào.'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final image = favorites[index];
                return FavoriteImageItem(
                  image: image,
                  isFavorite: isFavorite(image),
                  onToggleFavorite: () => onToggleFavorite(image),
                  onTapImage: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageDetailScreen(
                          image: image,
                          isFavorite: isFavorite(image),
                          onToggleFavorite: () => onToggleFavorite(image),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class FavoriteImageItem extends StatefulWidget {
  final PixabayImage image;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTapImage;

  const FavoriteImageItem({
    super.key,
    required this.image,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTapImage,
  });

  @override
  State<FavoriteImageItem> createState() => _FavoriteImageItemState();
}

class _FavoriteImageItemState extends State<FavoriteImageItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: widget.onTapImage,
          child: Stack(
            children: [
              Hero(
                tag: 'image_${widget.image.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Image.network(
                      widget.image.webformatURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (_isHovered)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red.shade400,
                        size: 48,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
