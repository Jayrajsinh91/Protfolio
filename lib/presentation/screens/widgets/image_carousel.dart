import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 300,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FlutterCarousel(
              options: CarouselOptions(
                height: widget.height,
                showIndicator: false,
                autoPlay: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: widget.imageUrls.map((url) {
                return Image(
                  image: AssetImage(url),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 10 : 5,
                height: 5,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
} 