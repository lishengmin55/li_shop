import 'package:flutter/material.dart';
import 'dart:async';

import 'package:li_shop/viewmodels/home.dart';

class HomeSlider extends StatefulWidget {
  final List<BannerItem> banners;
  const HomeSlider({Key? key, required this.banners}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

// 默认静态图片轮播数据
List<BannerItem> getDefaultBanners() {
  return [
    BannerItem(id: '1', imgUrl: 'assets/image.png'),
    BannerItem(id: '2', imgUrl: 'assets/image copy.png'),
    BannerItem(id: '3', imgUrl: 'assets/image copy2.png'),
  ];
}

class _HomeSliderState extends State<HomeSlider> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (widget.banners.isNotEmpty) {
        if (_currentIndex < widget.banners.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        _controller.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text('暂无轮播图'),
      );
    }

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              BannerItem banner = widget.banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: _getImageProvider(banner.imgUrl),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.banners.asMap().entries.map((entry) {
                int index = entry.key;
                bool isActive = _currentIndex == index;
                return GestureDetector(
                  onTap: () {
                    _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isActive ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isActive
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _getImageProvider(String imgUrl) {
    if (imgUrl.startsWith('http://') || imgUrl.startsWith('https://')) {
      return NetworkImage(imgUrl);
    } else {
      return AssetImage(imgUrl);
    }
  }
}
