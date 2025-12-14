import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/pixabay_image.dart';
import '../services/pixabay_service.dart';
import 'image_detail_screens.dart';

class HomeScreen extends StatefulWidget {
  final List<PixabayImage> favorites;
  final void Function(PixabayImage image) onToggleFavorite;
  final bool Function(PixabayImage image) isFavorite;
  final VoidCallback onViewFavorites;
  final VoidCallback onViewUploads;
  final VoidCallback onLogout;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const HomeScreen({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
    required this.isFavorite,
    required this.onViewFavorites,
    required this.onViewUploads,
    required this.onLogout,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PixabayService _pixabayService = PixabayService();
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = '';
  bool _isLoading = false;
  String _errorMessage = '';
  List<PixabayImage> _images = [];

  final List<Map<String, String>> _categories = [
    {'value': '', 'label': 'Tất cả'},
    {'value': 'backgrounds', 'label': 'Hình nền'},
    {'value': 'fashion', 'label': 'Thời trang'},
    {'value': 'nature', 'label': 'Thiên nhiên'},
    {'value': 'science', 'label': 'Khoa học'},
    {'value': 'education', 'label': 'Giáo dục'},
    {'value': 'feelings', 'label': 'Cảm xúc'},
    {'value': 'health', 'label': 'Sức khỏe'},
    {'value': 'people', 'label': 'Con người'},
    {'value': 'religion', 'label': 'Tôn giáo'},
    {'value': 'places', 'label': 'Địa điểm'},
    {'value': 'animals', 'label': 'Động vật'},
    {'value': 'industry', 'label': 'Công nghiệp'},
    {'value': 'food', 'label': 'Ẩm thực'},
    {'value': 'computer', 'label': 'Máy tính'},
    {'value': 'sports', 'label': 'Thể thao'},
    {'value': 'transportation', 'label': 'Giao thông'},
    {'value': 'travel', 'label': 'Du lịch'},
    {'value': 'buildings', 'label': 'Công trình'},
    {'value': 'business', 'label': 'Kinh doanh'},
    {'value': 'music', 'label': 'Âm nhạc'},
  ];

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
    _searchImages();
  }

  Future<void> _searchImages() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _pixabayService.searchImages(
        query: _searchController.text.trim(),
        category: _selectedCategory.isEmpty ? null : _selectedCategory,
      );

      setState(() {
        _images = response.hits;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 6;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = _getCrossAxisCount(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar (scrollable header)
          SliverAppBar(
            expandedHeight: 380,
            floating: false,
            pinned: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const NetworkImage(
                      'https://cdn.pixabay.com/index/2025/12/05/02-25-44-821_640.jpg',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Navigation Bar
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo bên trái
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                              'pixabay',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Buttons bên phải
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Dark mode
                              IconButton(
                                tooltip: 'Dark mode',
                                icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                                onPressed: widget.onToggleDarkMode,
                              ),
                              const SizedBox(width: 8),
                              // My Uploads
                              TextButton.icon(
                                onPressed: widget.onViewUploads,
                                icon: const Icon(Icons.person),
                                label: const Text('Uploads'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Favorites
                              TextButton.icon(
                                onPressed: widget.onViewFavorites,
                                icon: const Icon(Icons.favorite_outline),
                                label: const Text('Favorites'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Logout
                              TextButton.icon(
                                onPressed: widget.onLogout,
                                icon: const Icon(Icons.logout),
                                label: const Text('Logout'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      titleSpacing: 0,
                    ),
                    // Search Section (trên nền hình)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          // Tagline
                          const Text(
                            'Stunning royalty-free images & royalty-free stock',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          // Search Bar
                          SizedBox(
                            width: 600,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search for free images, videos, music & more',
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    icon: const Icon(Icons.search, color: Colors.grey),
                                    onPressed: _searchImages,
                                  ),
                                ),
                              ),
                              onSubmitted: (_) => _searchImages(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Tags
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildTag('nature'),
                                _buildTag('christmas'),
                                _buildTag('flowers'),
                                _buildTag('festive'),
                                _buildTag('forest'),
                                _buildTag('background'),
                                _buildTag('holidays'),
                                _buildTag('cat'),
                                _buildTag('sky'),
                                _buildTag('office'),
                                _buildTag('sunset'),
                                _buildTag('wallpaper'),
                                _buildTag('dog'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Category Dropdown
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map(
                            (c) => DropdownMenuItem<String>(
                              value: c['value'],
                              child: Text(c['label']!),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value ?? '';
                        });
                        _searchImages();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Grid images with masonry layout
          if (_isLoading)
            SliverFillRemaining(
              child: const Center(child: CircularProgressIndicator()),
            )
          else if (_errorMessage.isNotEmpty)
            SliverFillRemaining(
              child: Center(child: Text('Lỗi: $_errorMessage')),
            )
          else if (_images.isEmpty)
            SliverFillRemaining(
              child: const Center(
                child: Text('Không tìm thấy hình ảnh nào.'),
              ),
            )
          else
            SliverToBoxAdapter(
              child: MasonryGridView.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: _images.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final image = _images[index];
                  // Variable heights for masonry layout
                  final heights = [150.0, 180.0, 160.0, 190.0, 170.0, 155.0, 175.0, 185.0];
                  final height = heights[index % heights.length];
                  
                  return SizedBox(
                    height: height,
                    child: ImageGridItem(
                      image: image,
                      isFavorite: widget.isFavorite(image),
                      onTapImage: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ImageDetailScreen(
                              image: image,
                              isFavorite: widget.isFavorite(image),
                              onToggleFavorite: () {
                                widget.onToggleFavorite(image);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                      onToggleFavorite: () {
                        widget.onToggleFavorite(image);
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          tag,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  final PixabayImage image;
  final bool isFavorite;
  final VoidCallback onTapImage;
  final VoidCallback onToggleFavorite;

  const ImageGridItem({
    super.key,
    required this.image,
    required this.isFavorite,
    required this.onTapImage,
    required this.onToggleFavorite,
  });

  @override
  State<ImageGridItem> createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(0)..rotateY(0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.5 : 0.15),
              blurRadius: _isHovered ? 28 : 10,
              offset: Offset(0, _isHovered ? 14 : 5),
              spreadRadius: _isHovered ? 3 : 1,
            ),
          ],
        ),
        child: AnimatedScale(
          scale: _isHovered ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: widget.onTapImage,
            child: Stack(
              children: [
                Hero(
                  tag: 'image_${widget.image.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.image.webformatURL,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                if (_isHovered || widget.isFavorite)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 20,
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorite
                              ? Colors.redAccent
                              : Colors.white,
                        ),
                        onPressed: widget.onToggleFavorite,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
