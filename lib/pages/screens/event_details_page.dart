import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const NewsDetailPage({super.key, required this.data});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
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
          // Custom App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'news_image_1', // Unique tag for animation
                    child: Image.asset(
                      'assets/news_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Status
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
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
                        child: const Text(
                          'Fashion Show',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B894),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Upcoming',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'Annual Fashion Designer Awards 2024',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                ),

                // Date, Time and Location Card
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 100),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.calendar_today,
                            color: Color(0xFF6C5CE7)),
                        title: Text('Date'),
                        subtitle: Text('December 15, 2024'),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      const ListTile(
                        leading:
                            Icon(Icons.access_time, color: Color(0xFF6C5CE7)),
                        title: Text('Time'),
                        subtitle: Text('7:00 PM - 10:00 PM'),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.location_on,
                            color: Color(0xFF6C5CE7)),
                        title: const Text('Location'),
                        subtitle: const Text('Grand Fashion Arena'),
                        trailing: IconButton(
                          icon: const Icon(Icons.map_outlined),
                          onPressed: () {
                            // Handle map navigation
                          },
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),

                // Description
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Join us for the most prestigious fashion event of the year. The Annual Fashion Designer Awards celebrates excellence in fashion design and innovation...',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Color(0xFF636E72),
                        ),
                      ),
                    ],
                  ),
                ),

                // Video Section

                Container(
                  margin: const EdgeInsets.all(20),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
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
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 60,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Posted By Section
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F2F6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/poster_avatar.jpg'),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Posted by',
                              style: TextStyle(
                                color: Color(0xFF636E72),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Sarah Johnson',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Posted on ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
                              style: const TextStyle(
                                color: Color(0xFF636E72),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Share and Save Buttons
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C5CE7),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.bookmark_border),
                          label: const Text('Save'),
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
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
