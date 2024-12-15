import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EventDetailsPage extends StatefulWidget {
  final EventModel data;
  const EventDetailsPage({super.key, required this.data});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Ensure video controller is only initialized when the URL is valid
    if (widget.data.videoLink != null) {
      final videoId = YoutubePlayer.convertUrlToId(widget.data.videoLink!);
      if (videoId != null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      } else {
        debugPrint("Invalid video URL.");
      }
    } else {
      debugPrint("No video URL found.");
    }
  }

  @override
  void dispose() {
    //_controller.dispose();
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
                    child: widget.data.imageUrl.isNotEmpty == true
                        ? Image.network(
                            widget.data
                                .eventBanner!, // Use the actual image if it's not empty
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/placeholder.png', // Default placeholder if imageUrl is empty or null
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
                          Colors.black.withAlpha(100),
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
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
                      // Category Label
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FutureBuilder<String>(
                          future: AppModel().getCategoryNameById(widget
                              .data.category!), // Fetch category name by ID
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}',
                                  style: const TextStyle(
                                      color: Colors.white)); // Handle error
                            } else if (snapshot.hasData) {
                              return Text(
                                snapshot.data?.toUpperCase() ??
                                    'Category not found',
                                style: const TextStyle(color: Colors.white),
                              ); // Display category title
                            } else {
                              return Text('Category not found',
                                  style: const TextStyle(
                                      color:
                                          Colors.white)); // Fallback if no data
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Status Label
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B894),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.data.status!.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    widget.data.title,
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
                      ListTile(
                        leading: Icon(Icons.calendar_today,
                            color: Color(0xFF6C5CE7)),
                        title: Text('Date'),
                        subtitle: Text(TextHelper.formatDate(widget.data.date)),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        leading:
                            Icon(Icons.access_time, color: Color(0xFF6C5CE7)),
                        title: Text('Time'),
                        subtitle: Text(widget.data.time!),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.location_on,
                            color: Color(0xFF6C5CE7)),
                        title: const Text('Location'),
                        subtitle: Text(widget.data.location!),
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
                  child: Column(
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
                        widget.data.desc,
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
                      // CircleAvatar to display the author's image with fade-in effect
                      // CircleAvatar with FadeInImage widget for the author's profile picture
                      // CircleAvatar(
                      //   radius: 25,
                      //   child: FutureBuilder<String>(
                      //     future: AppModel().getAuthorImageById(widget.data
                      //         .createdBy), // Fetch the author's profile image by ID
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         // Show placeholder while loading
                      //         return FadeInImage.assetNetwork(
                      //           placeholder: 'assets/images/placeholder.png',
                      //           image: '', // No image URL yet
                      //           fadeInDuration: Duration(milliseconds: 300),
                      //           width:
                      //               50, // Set the width and height to match the CircleAvatar size
                      //           height: 50,
                      //           fit: BoxFit.cover,
                      //         );
                      //       } else if (snapshot.hasError) {
                      //         // Show placeholder if there is an error
                      //         return FadeInImage.assetNetwork(
                      //           placeholder: 'assets/images/placeholder.png',
                      //           image:
                      //               '', // Fallback to placeholder in case of error
                      //           fadeInDuration: Duration(milliseconds: 300),
                      //           width: 50,
                      //           height: 50,
                      //           fit: BoxFit.cover,
                      //         );
                      //       } else if (snapshot.hasData &&
                      //           snapshot.data!.isNotEmpty) {
                      //         // Show the actual image when data is available
                      //         return FadeInImage.assetNetwork(
                      //           placeholder: 'assets/images/placeholder.png',
                      //           image: snapshot.data ??
                      //               '', // Provide fallback for null URLs
                      //           fadeInDuration:
                      //               const Duration(milliseconds: 300),
                      //           imageErrorBuilder:
                      //               (context, error, stackTrace) {
                      //             return Image.asset(
                      //               'assets/images/placeholder.png',
                      //               width: 50,
                      //               height: 50,
                      //               fit: BoxFit.cover,
                      //             ); // Fallback image on error
                      //           },
                      //           width: 50,
                      //           height: 50,
                      //           fit: BoxFit.cover,
                      //         );
                      //       } else {
                      //         // Show placeholder if no image URL is found
                      //         return FadeInImage.assetNetwork(
                      //           placeholder: 'assets/images/placeholder.png',
                      //           image:
                      //               '', // Fallback to placeholder if no data is found
                      //           fadeInDuration: Duration(milliseconds: 300),
                      //           width: 50,
                      //           height: 50,
                      //           fit: BoxFit.cover,
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),

                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Posted by',
                              style: TextStyle(
                                color: Color(0xFF636E72),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            FutureBuilder<String>(
                              future: AppModel().getAuthorNameById(widget
                                  .data.createdBy), // Fetch auhtor name by ID
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Show loading indicator
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'FDAG',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ); // Handle error
                                } else if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data?.toUpperCase() ?? 'FDAG',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ); // Display category title
                                } else {
                                  return Text(
                                    'FDAG',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ); // Fallback if no data
                                }
                              },
                            ),
                            Text(
                              'Posted on ${TextHelper.formatDate(widget.data.createdOn!)}',
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
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          label: const Text('Share'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 42, 107, 248),
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
