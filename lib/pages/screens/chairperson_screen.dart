import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ChairpersonScreen
class ChairpersonScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const ChairpersonScreen({super.key, required this.data});

  @override
  State<ChairpersonScreen> createState() => _ChairpersonScreenState();
}

class _ChairpersonScreenState extends State<ChairpersonScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Ensure video controller is only initialized when the URL is valid
    if (widget.data['videoUrl'] != null) {
      debugPrint(widget.data['videoUrl']);
      final videoId = YoutubePlayer.convertUrlToId(widget.data['videoUrl']);
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      // Handle the case where there's no video URL
      debugPrint("No video URL found.");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Image
          SliverAppBar(
            leading: Icon(Icons.arrow_back_ios),
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.data['imageUrl'] != null)
                    FadeInImage.assetNetwork(
                      placeholder:
                          'assets/images/placeholder.png', // Placeholder image
                      image: widget.data['imageUrl'] ?? '', // Fetched image URL
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png', // Fallback if image fails to load
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        );
                      },
                    ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(
                              alpha: 150, red: 0, green: 0, blue: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                widget.data['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Position
                  Row(
                    children: [
                      Text(
                        widget.data['position'],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const Spacer(),
                      // Social Media Icons
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {},
                            color: const Color(0xFF0077B5),
                          ),
                          IconButton(
                            icon: Icon(Icons.phone_android),
                            onPressed: () {},
                            color: Color(0xFF1DA1F2),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Message Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data['title'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          widget.data['content'],
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Color(0xFF34495E),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Video Section
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          onReady: () {
                            debugPrint('Player is ready.');
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Additional Info or Quote
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.format_quote,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '"Fashion is about dreaming and making other people dream."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
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
