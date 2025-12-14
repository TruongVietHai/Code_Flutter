import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class MyUploadsScreen extends StatefulWidget {
  final List<Uint8List> images;
  final VoidCallback onBack;
  final void Function(List<Uint8List>) onAddUploads;

  const MyUploadsScreen({
    super.key,
    required this.images,
    required this.onBack,
    required this.onAddUploads,
  });

  @override
  State<MyUploadsScreen> createState() => _MyUploadsScreenState();
}

class _MyUploadsScreenState extends State<MyUploadsScreen> {
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 6;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  Future<void> _pickImages() async {
    try {
      print('Bắt đầu chọn ảnh...');
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      print('Kết quả: $result');
      print('Files: ${result?.files}');

      if (result != null && result.files.isNotEmpty) {
        print('Số file được chọn: ${result.files.length}');
        final newImages = <Uint8List>[];
        for (final file in result.files) {
          print('File: ${file.name}, Path: ${file.path}, Bytes: ${file.bytes?.length}');
          
          Uint8List? imageBytes;
          
          // Thử lấy bytes từ file object trước
          if (file.bytes != null) {
            imageBytes = file.bytes;
          }
          // Nếu không có bytes, đọc từ path
          else if (file.path != null) {
            try {
              imageBytes = await File(file.path!).readAsBytes();
              print('Đã đọc file từ path: ${file.path}');
            } catch (e) {
              print('Lỗi đọc file: $e');
            }
          }
          
          if (imageBytes != null) {
            newImages.add(imageBytes);
          }
        }
        print('Số ảnh được thêm: ${newImages.length}');
        if (newImages.isNotEmpty) {
          widget.onAddUploads(newImages);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã tải lên ${newImages.length} ảnh')),
            );
          }
        }
      } else {
        print('Không có file nào được chọn - Thêm ảnh thử nghiệm');
        if (mounted) {
          _showAddTestImageDialog();
        }
      }
    } catch (e) {
      print('Lỗi: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  Future<void> _loadAndAddTestImage() async {
    try {
      final response = await http
          .get(Uri.parse('https://via.placeholder.com/300x300/0066cc/ffffff?text=Test'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200 && mounted) {
        widget.onAddUploads([response.bodyBytes]);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã thêm 1 ảnh thử nghiệm')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tải ảnh: $e')),
        );
      }
    }
  }

  void _showAddTestImageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Thêm ảnh thử nghiệm?'),
        content: const Text('Không thể chọn ảnh từ file picker. Bạn có muốn thêm ảnh thử nghiệm không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _loadAndAddTestImage();
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  void _deleteImage(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa ảnh'),
        content: const Text('Bạn có chắc chắn muốn xóa ảnh này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.images.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Ảnh tải lên'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _pickImages,
          ),
        ],
      ),
      body: widget.images.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Bạn chưa tải lên ảnh nào.'),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return UploadImageItem(
                  imageBytes: widget.images[index],
                  onDelete: () => _deleteImage(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        tooltip: 'Thêm ảnh',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UploadImageItem extends StatefulWidget {
  final Uint8List imageBytes;
  final VoidCallback onDelete;

  const UploadImageItem({
    super.key,
    required this.imageBytes,
    required this.onDelete,
  });

  @override
  State<UploadImageItem> createState() => _UploadImageItemState();
}

class _UploadImageItemState extends State<UploadImageItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
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
                child: Image.memory(
                  widget.imageBytes,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (_isHovered)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
            Positioned(
              top: 8,
              right: 8,
              child: AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.7,
                duration: const Duration(milliseconds: 200),
                child: GestureDetector(
                  onTap: widget.onDelete,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
