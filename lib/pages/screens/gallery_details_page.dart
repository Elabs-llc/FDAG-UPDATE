import 'package:flutter/material.dart';

class GalleryDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  const GalleryDetailsPage(
      {super.key, required this.imageUrl, required this.title});

  @override
  State<GalleryDetailsPage> createState() => _GalleryDetailsPageState();
}

class _GalleryDetailsPageState extends State<GalleryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          InteractiveViewer(
            child: Center(
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(widget.title),
              actions: [
                Hero(
                  tag:
                      'share-button-${widget.title}-${widget.imageUrl}', // Unique tag for each Hero
                  child: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // Implement share functionality
                    },
                  ),
                ),
                Hero(
                  tag:
                      'download-button-${widget.title}-${widget.imageUrl}', // Unique tag for each Hero
                  child: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      // Implement download functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
