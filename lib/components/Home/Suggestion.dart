import 'package:flutter/material.dart';
import 'package:li_shop/viewmodels/home.dart';

class Suggestion extends StatefulWidget {
  final HomeRecommendResult suggestion;
  const Suggestion({Key? key, required this.suggestion}) : super(key: key);

  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    if (widget.suggestion.subTypes.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      color: Colors.cyan.shade50,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.suggestion.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          _buildSubTypes(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      color: Colors.cyan.shade50,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text('暂无推荐数据', style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildSubTypes() {
    return Column(
      children: widget.suggestion.subTypes.map((subType) {
        return _buildSubTypeSection(subType);
      }).toList(),
    );
  }

  Widget _buildSubTypeSection(SubTypeItem subType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            subType.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subType.goodsItems.items.length,
            itemBuilder: (context, index) {
              return _buildGoodsItem(subType.goodsItems.items[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGoodsItem(GoodsItem goods) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              goods.picture,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 150,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 100,
                  width: 150,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goods.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '¥${goods.price}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[600],
                        ),
                      ),
                      Text(
                        '已售${goods.orderNum}',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
