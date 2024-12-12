import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ChairpersonScreen
class ChairpersonScreen extends StatefulWidget {
  const ChairpersonScreen({super.key});

  @override
  State<ChairpersonScreen> createState() => _ChairpersonScreenState();
}

class _ChairpersonScreenState extends State<ChairpersonScreen> {
  // late VideoPlayerController _controller;
  // bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse('YOUR_VIDEO_URL_HERE'),
    // )..initialize().then((_) {
    //     setState(() {
    //       _isVideoInitialized = true;
    //     });
    //   });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: const Text(
                'Jane Doe',
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
                      const Text(
                        'Chairperson',
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
                            icon: Icon((Icons.earbuds_battery)),
                            onPressed: () {},
                            color: Color(0xFFE1306C),
                          ),
                          IconButton(
                            icon: Icon(Icons.access_alarm_sharp),
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Message from the Chairperson',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Your message content goes here. This is a detailed message from the chairperson explaining their vision, mission, and thoughts about the fashion designer association...',
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
                        // _isVideoInitialized
                        //     ? AspectRatio(
                        //         aspectRatio: _controller.value.aspectRatio,
                        //         child: VideoPlayer(_controller),
                        //       )
                        //     : const Center(
                        //         child: CircularProgressIndicator(),
                        //       ),
                        // IconButton(
                        //   icon: Icon(
                        //     _controller.value.isPlaying
                        //         ? Icons.pause_circle_filled
                        //         : Icons.play_circle_filled,
                        //     size: 60,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       _controller.value.isPlaying
                        //           ? _controller.pause()
                        //           : _controller.play();
                        //     });
                        //   },
                        // ),
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
