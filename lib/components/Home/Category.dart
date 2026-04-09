import 'package:flutter/material.dart';
import 'package:li_shop/viewmodels/home.dart';

class Category extends StatefulWidget {

  final List<CategoryItem> categories;
  const Category({Key? key, required this.categories}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return Container(
        height: 120,
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text('暂无分类数据'),
      );
    }

    return Container(
      height: 140,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return _buildCategoryItem(widget.categories[index]);
        },
      ),
    );
  }

  Widget _buildCategoryItem(CategoryItem category) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[200],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              category.picture,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 30,
                    color: Colors.grey,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
