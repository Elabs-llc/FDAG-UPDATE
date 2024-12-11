import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/elabs/config.dart';
import 'package:fdag/models/event_model.dart';
import 'package:fdag/pages/top_navigation.dart';
import 'package:fdag/utils/device/network_provider.dart';
import 'package:fdag/utils/device/network_type.dart';
import 'package:fdag/utils/helpers/expande_notifier.dart';
import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:fdag/utils/widgets/line.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/// A [ConsumerWidget] representing the home view of the application,
/// displaying various sections such as welcome message, chairperson's message,
/// quick links, and upcoming events etc.
class HomeView extends ConsumerWidget {
  AppModel appModel = AppModel();

  final List<String> events = [
    'Event 1',
    'Event 2',
    'Event 3',
    'Event 4',
    'Event 5',
    'Event 6',
    'Event 7',
  ];

  HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final connectionStatus = ref.watch(connectivityProvider);
    final isExpanded = ref.watch(expandProvider);

    return Scaffold(
      backgroundColor: ElColor.darkBlue100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TopNavigation(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                _buildWelcomeCard(context, ref, isExpanded),
                AppWidgets.blankSpace(),
                AppWidgets.buildChairpersonMessageCard(
                    context: context,
                    message: TextHelper.truncateText(Config.defaultText,
                        length: 120)),
                AppWidgets.blankSpace(),
                AppWidgets().buildQuickLinks(context),
                AppWidgets.blankSpace(),

                /// Builds the title for the upcoming events section.
                AppWidgets.buildTitle(
                    title: Config.event_title, icon: Icons.arrow_forward_ios),
                _buildUpcomingEventsList(ref),
                AppWidgets.blankSpace(),

                /// Builds the title for the lastest news and update section.
                AppWidgets.buildTitle(
                    title: Config.latest_news_title,
                    icon: Icons.arrow_forward_ios),
                _buildNewsUpdateList(ref),
                AppWidgets.blankSpace(),

                /// Builds the title spotlight section section.
                AppWidgets.buildTitle(
                    title: Config.spotlight_title,
                    icon: Icons.arrow_forward_ios),
                _buildSpotlightList(ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the welcome card displaying a welcome message and
  /// a button to expand or collapse the message.
  Card _buildWelcomeCard(BuildContext context, WidgetRef ref, bool isExpanded) {
    return Card(
      color: ElColor.white,
      elevation: Sizes.f4,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: appModel.fetchWelcomeMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            debugPrint('Error fetching welcome messages: ${snapshot.error}');
            return Center(
              child: Text('Error fetching welcome messages'),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic>? data = snapshot.data;
            if (data == null || data.isEmpty) {
              return Center(
                child: Text('Welcome message data is missing required fields.'),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Line.verticalLine(color: ElColor.gold, width: Sizes.f001),
                      Line.space(),
                      Text(
                        "${data['title']}",
                        style: ElColor.blackColor2,
                      ),
                      Spacer(), // Add space between text and icon
                      IconButton(
                        highlightColor: ElColor.gold,
                        splashColor: ElColor.gold,
                        focusColor: ElColor.gold,
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: ElColor.darkBlue,
                        ),
                        onPressed: () {
                          ref.read(expandProvider.notifier).toggle();
                        },
                      ),
                    ],
                  ),
                ),
                isExpanded
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${data['content']}",
                          style: ElColor.blackColor3,
                        ),
                      )
                    : Container(),
              ],
            );
          }

          // In case no data is available
          return Center(child: Text('No welcome message available.'));
        },
      ),
    );
  }

  /// Builds a list of upcoming events displayed horizontally.
  SizedBox _buildUpcomingEventsList(WidgetRef ref) {
    final connectionStatus = ref.watch(connectivityProvider);
    return SizedBox(
      height: 200.0,
      child: StreamBuilder<List<EventModel>>(
        stream: appModel.fetchUpcomingEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching upcoming events.'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<EventModel> events = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return AppWidgets.buildPoster(
                    posterData: events[index],
                    connectionStatus: connectionStatus);
              },
            );
          } else {
            // No upcoming events; fetch and display completed events
            return StreamBuilder<List<EventModel>>(
              stream: appModel.fetchCompletedEvents(),
              builder: (context, completedSnapshot) {
                if (completedSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (completedSnapshot.hasError) {
                  return Center(
                      child: Text('Error fetching completed events.'));
                } else if (completedSnapshot.hasData &&
                    completedSnapshot.data!.isNotEmpty) {
                  List<EventModel> completedEvents = completedSnapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: completedEvents.length,
                    itemBuilder: (context, index) {
                      return buildCompletedEventPoster(
                          event: completedEvents[index],
                          connectionStatus: connectionStatus);
                    },
                  );
                } else {
                  return Center(child: Text('No events available.'));
                }
              },
            );
          }
        },
      ),
    );
  }

  /// Builds an event poster for completed events with a "Completed" tag overlay.
  Widget buildCompletedEventPoster(
      {required EventModel event, ConnectionStatus? connectionStatus}) {
    return Stack(
      children: [
        AppWidgets.buildPoster(
            posterData: event, connectionStatus: connectionStatus),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: EdgeInsets.all(4.0),
            color: Colors.redAccent,
            child: Text(
              'Completed',
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.f001,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a list of latest news and updates displayed horizontally.
  SizedBox _buildNewsUpdateList(WidgetRef ref) {
    final connectionStatus = ref.watch(connectivityProvider);
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          //return AppWidgets.buildPoster(connectionStatus: connectionStatus, width: 260.0, height: 150.0);
        },
      ),
    );
  }

  /// Builds a list of spolights features displayed horizontally.
  SizedBox _buildSpotlightList(WidgetRef ref) {
    final connectionStatus = ref.watch(connectivityProvider);
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          // return AppWidgets.buildPoster(connectionStatus: connectionStatus, width: 360.0, height: 150.0);
        },
      ),
    );
  }
}
