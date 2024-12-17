import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // Custom App Bar
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: const Color.fromARGB(55, 15, 14, 17),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Gallery Cover Image
                    Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(2),
                          ],
                        ),
                      ),
                    ),
                    // Title Content
                    Positioned(
                      bottom: 60,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Capturing moments in fashion',
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Founding Members'),
                  Tab(text: 'Events'),
                  Tab(text: 'Fashion Shows'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            AppWidgets().buildAllGallery(),
            AppWidgets().buildFoundingMembers(),
            AppWidgets().buildEventsGallery(),
            AppWidgets().buildFashionShows(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C5CE7),
        child: const Icon(Icons.filter_list),
        onPressed: () {
          _showFilterBottomSheet();
        },
      ),
    );
  }

  // void _showImageDetail(String imageUrl, String title) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => ImageDetailPage(
  //         imageUrl: imageUrl,
  //         title: title,
  //       ),
  //     ),
  //   );
  // }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Filter Gallery',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Add your filter options here
            ],
          ),
        );
      },
    );
  }
}

// class ImageDetailPage extends StatelessWidget {
//   final String imageUrl;
//   final String title;

//   const ImageDetailPage({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Image
//           InteractiveViewer(
//             child: Center(
//               child: Image.asset(
//                 imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           // Top Bar
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: Text(title),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.share),
//                   onPressed: () {
//                     // Implement share functionality
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.download),
//                   onPressed: () {
//                     // Implement download functionality
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
