import 'package:animate_do/animate_do.dart';
import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/elabs/config.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/models/founder.dart';
import 'package:fdag/models/poster_data.dart';
import 'package:fdag/pages/screens/chairperson_screen.dart';
import 'package:fdag/pages/screens/event_details_page.dart';
import 'package:fdag/utils/device/network_type.dart';
import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:fdag/utils/widgets/line.dart';
import 'package:flutter/material.dart';

class AppWidgets {
  AppModel appModel = AppModel();

  /// Builds the chairperson's message card containing a photo and a brief message.
  // static Widget buildChairpersonMessageCard(
  //     {required BuildContext context,
  //     String? message,
  //     int? length,
  //     String? imageUrl}) {
  //   return Card(
  //     color: ElColor.white,
  //     elevation: Sizes.f14,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               Line.verticalLine(color: ElColor.gold, width: Sizes.f001),
  //               Line.space(),
  //               Text(
  //                 Config.remarkText,
  //                 style: ElColor.blackColor2,
  //               ),
  //             ],
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(Sizes.f1),
  //                   child: Image.asset(
  //                     'assets/images/ceo.jpg',
  //                     width: Sizes.f6,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     Config.defaultHead,
  //                     style: ElColor.blackColor2,
  //                   ),
  //                   Text(
  //                     TextHelper.truncateText(message ?? Config.defaultText,
  //                         length: length ?? 120),
  //                     style: ElColor.blackColor3,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: ElevatedButton(
  //                       onPressed: () {}, // Navigate to Chairperson page
  //                       child: Text(Config.read_more),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static Widget buildChairpersonMessageCard(
      {required BuildContext context,
      String? message,
      int? length,
      String? imageUrl,
      String? title,
      List<Map<String, dynamic>>? data}) {
    // Fallbacks for missing parameters
    final defaultImage =
        'assets/images/placeholder.png'; // Placeholder image path
    final defaultMessage = Config.defaultText; // Default message text

    return Card(
      color: ElColor.white,
      elevation: Sizes.f14,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Line.verticalLine(color: ElColor.gold, width: Sizes.f001),
                Line.space(),
                Text(
                  Config.remarkText,
                  style: ElColor.blackColor2,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.f1),
                    child: FadeInImage.assetNetwork(
                      placeholder: defaultImage, // Placeholder image
                      image: imageUrl ??
                          '', // Actual image URL (fallback to empty)
                      width: Sizes.f6,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        // Handle error: show placeholder image
                        return Image.asset(defaultImage, width: Sizes.f6);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? Config.defaultHead,
                      style: ElColor.blackColor2,
                    ),
                    Text(
                      TextHelper.truncateText(
                        message ??
                            defaultMessage, // Use default message if null
                        length: length ?? 100,
                      ),
                      style: ElColor.blackColor3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChairpersonScreen(
                                      data: data!.first,
                                    )),
                          );
                        }, // Navigate to Chairperson page
                        child: Text(Config.read_more),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a card containing quick links represented by icons.
  Widget buildQuickLinks(
      {required BuildContext context, List<Widget>? children}) {
    return Card(
      color: ElColor.white,
      elevation: MediaQuery.of(context).size.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...?children,
          ],
          // children: List.generate(4, (index) {
          //   // Return a quick link icon

          //   return _buildQuickLinkIcon();
          // }),
        ),
      ),
    );
  }

  /// Returns a quick link icon wrapped in a circular container.
  Widget buildQuickLinkIcon({Widget? child, Function? action, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.f4),
      child: SizedBox(
        width: Sizes.f10,
        height: Sizes.f10,
        child: ColoredBox(
          color: color ?? ElColor.gold,
          child: InkWell(
              child: child,
              // icon ?? Icons.business_rounded),
              onTap: () {
                // Implement quick link functionality
                action!();
              }),
        ),
      ),
    );
  }

  /// Builds the section title
  static Widget buildTitle(
      {String? title,
      double? padding,
      Color? color,
      double? fontSize,
      double? iconSize,
      Color? iconColor,
      TextStyle? style,
      Color? verticalLineColor,
      double? verticalLineWidth,
      IconData? icon,
      Function? action}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Line.verticalLine(
              color: verticalLineColor ?? ElColor.gold,
              width: verticalLineWidth ?? Sizes.f001),
          Line.space(),
          Text(
            title ?? Config.defaultSectionTitle,
            style: style ?? ElColor.blackColor2,
          ),
          Spacer(), // Add space between text and icon
          IconButton(
            highlightColor: ElColor.gold,
            splashColor: ElColor.gold,
            focusColor: ElColor.gold,
            icon: Icon(icon ?? Icons.arrow_forward,
                color: iconColor ?? ElColor.darkBlue),
            onPressed: () {
              // Add your onPressed logic here
              action!();
            },
          ),
        ],
      ),
    );
  }

  static buildPoster(
      {required PosterData posterData,
      EventModel? event,
      ConnectionStatus? connectionStatus,
      BuildContext? context,
      double? width,
      double? height}) {
    String imageUrl = posterData.imageUrl;

    return InkWell(
      onTap: () {
        // Navigate to event details
        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
              data: event!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            // Using Image.network directly to reduce loading delay
            Image.network(
              connectionStatus == ConnectionStatus.none || imageUrl.isEmpty
                  ? 'assets/images/placeholder.png' // Show placeholder if no connection
                  : imageUrl, // Actual image URL
              fit: BoxFit.cover,
              width: width ?? 150,
              height: height ?? 300,
              loadingBuilder: (context, child, loadingProgress) {
                // Show the loading indicator while the image is loading
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                // If there's an error loading the image, show the placeholder
                Logger.logLevel = 'ERROR';
                Logger.error("Elabs App Log: Unable to fetch event image url");
                return Image.asset('assets/images/placeholder.png',
                    fit: BoxFit.cover);
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: ElColor.darkBlue500,
                child: Text(
                  TextHelper.truncateText(posterData.title, length: 17),
                  style: TextStyle(
                    color: ElColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: PopupMenuButton(
                padding: EdgeInsets.all(5.0),
                icon: SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.f5),
                    child: ColoredBox(
                      color: ElColor.gold,
                      child: Icon(
                        Icons.more_vert,
                        color: ElColor.darkBlue,
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "Favorite",
                      textStyle: ElColor.blackColor3,
                      child: Icon(Icons.favorite),
                    ),
                    PopupMenuItem(
                      value: "Share",
                      child: Icon(Icons.share),
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A widget representing a blank space, used for spacing in the layout.
  static Widget blankSpace() {
    return SizedBox(height: Sizes.f01);
  }

  static buildCard({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInUp(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ...children,
          ],
        ),
      ),
    );
  }

  static Widget buildAppBar(
      {required BuildContext context, String? appBarTitle}) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          appBarTitle ?? 'News & Updates',
          style: const TextStyle(
            color: Color(0xFF2D3436),
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality
              },
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: Sizes.xl,
            color: isSelected ? ElColor.textWhite : ElColor.black,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? ElColor.textWhite : ElColor.black,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildGalleryItem({
    required String? imageUrl,
    required String? title,
    required String? date,
    double? height,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        debugPrint('Gallery item tapped');
        onTap(); // Trigger the provided onTap callback
      },
      child: Container(
        height: height!,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: imageUrl ?? 'assets/images/placeholder.png',
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image), // Fallback for broken image
              ), // Default placeholder
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(50),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Untitled', // Default title
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date ?? 'Unknown Date', // Default date
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildFounderCard({
    String? name,
    String? role,
    String? imageUrl,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        debugPrint('Gallery item tapped');
        onTap!(); // Trigger the provided onTap callback
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        'assets/images/placeholder.png', // Your local placeholder image
                    image: imageUrl!,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        const Icon(
                            Icons.broken_image), // Fallback when image fails
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    role!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildEventCard({
    String? title,
    String? date,
    String? location,
    String? imageUrl,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        debugPrint('Gallery item tapped');
        onTap!(); // Trigger the provided onTap callback
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: imageUrl!,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image), // Fallback when image fails
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color(0xFF6C5CE7),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xFF6C5CE7),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        location!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildFashionShowCard({
    String? title,
    String? year,
    String? imageUrl,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        debugPrint('Gallery item tapped');
        onTap!(); // Trigger the provided onTap callback
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: imageUrl!,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image), // Fallback when image fails
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(50),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      year!,
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildFoundersCard(
      {required Founder founder, Function? onTap, required bool isEven}) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.only(top: isEven ? 30 : 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: founder.thumbnail,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image), // Fallback for broken image
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    founder.title, // title was used to replace name
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    founder.role,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
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
                      founder.specialty,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 239, 239, 240),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF6C5CE7),
                        ),
                        onPressed: () {
                          // Navigate to detailed profile
                          onTap!();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildHistoryCard({String? title, String? content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Historical Note',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C5CE7),
          ),
        ),
        SizedBox(height: 16),
        Text(
          content!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
