import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GalleryDetailsPage extends StatefulWidget {
  final List<String> images;
  final String title;
  final String date;
  final String description;
  final String category;

  const GalleryDetailsPage({
    super.key,
    required this.images,
    required this.title,
    required this.date,
    required this.description,
    required this.category,
  });

  @override
  State<GalleryDetailsPage> createState() => _GalleryDetailsPageState();
}

class _GalleryDetailsPageState extends State<GalleryDetailsPage> {
  late PageController _pageController;
  late CarouselSliderController _carouselController;
  int _currentIndex = 0;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _carouselController = CarouselSliderController();
    debugPrint('Images: ${widget.images}');
  }

  @override
  Widget build(BuildContext context) {
    if (_isFullScreen) {
      return _buildFullScreenGallery();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Image
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            // backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image Carousel
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: widget.images.length > 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: widget.images.asMap().entries.map((entry) {
                      final index = entry.key;
                      final image = entry.value;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFullScreen = true;
                            _pageController.jumpToPage(index);
                          });
                        },
                        child: Hero(
                          tag:
                              'gallery_image_$index', // Unique tag using the index
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  // Gradient Overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                  // Image Counter
                  if (widget.images.length > 1)
                    Positioned(
                      top: 60,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_currentIndex + 1}/${widget.images.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Thumbnails
                    if (widget.images.length > 1)
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _carouselController.animateToPage(index);
                              },
                              child: Container(
                                width: 60,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: index == _currentIndex
                                      ? Border.all(
                                          color: const Color(0xFF6C5CE7),
                                          width: 2,
                                        )
                                      : null,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    widget.images[index],
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // Title and Category
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C5CE7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  widget.category,
                                  style: const TextStyle(
                                    color: Color(0xFF6C5CE7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  // Implement share functionality
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () {
                                  // Implement download functionality
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.date,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenGallery() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full Screen Gallery
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: 'gallery_image_$index',
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollPhysics: const ClampingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),

          // Close Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isFullScreen = false;
                });
              },
            ),
          ),

          // Image Counter
          if (widget.images.length > 1)
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1}/${widget.images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
