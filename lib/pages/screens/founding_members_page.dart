import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/models/founder.dart';
import 'package:fdag/pages/screens/gallery_details_page.dart';
import 'package:fdag/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FoundingMembersPage extends StatelessWidget {
  const FoundingMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Animation
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(33, 255, 255, 255),
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            backgroundColor: const Color(0xFF6C5CE7),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Pattern or Image
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF6C5CE7),
                            const Color(0xFF574BC0),
                          ],
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.fill,
                      ),
                      // child: CustomPaint(
                      //   painter: PatternPainter(),
                      // ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: AppWidgets.buildCompanyInfo(child: (contents) {
                            final data = contents.isNotEmpty ? contents[0] : {};
                            return Text(
                              'EST ${TextHelper.getYear(data['estDate'])}',
                              style: const TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Founding Members',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AppWidgets.buildCompanyInfo(child: (contents) {
                          final data = contents.isNotEmpty ? contents[0] : {};
                          return Text(
                            data['name'] ??
                                'Fashion Design Association of Ghana',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Legacy Quote
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote,
                    size: 40,
                    color: Color(0xFF6C5CE7),
                  ),
                  const SizedBox(height: 16),
                  AppWidgets.buildCompanyInfo(child: (contents) {
                    final data = contents.isNotEmpty ? contents[0] : {};
                    return Text(
                      data['slogan'] ?? 'No legacy is so rich as honesty.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[800],
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Founding Members Grid
          FutureBuilder<List<Founder>>(
            future: AppModel().getFounders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Wrap the loading indicator in a SliverToBoxAdapter
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                // Wrap the error message in a SliverToBoxAdapter
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Wrap the "no data" message in a SliverToBoxAdapter
                return const SliverToBoxAdapter(
                  child: Center(child: Text('No founders available.')),
                );
              }

              final founders = snapshot.data!;

              // Founding Members Grid
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    final founder =
                        founders[index]; // Access the current founder object
                    return AppWidgets.buildFoundersCard(
                      founder: founder,
                      isEven: index.isEven,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GalleryDetailsPage(
                              images: [founder.thumbnail],
                              title: founder.title,
                              date: '',
                              description: founder.bio,
                              category: 'founders',
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: founders.length,
                ),
              );
            },
          ),

          // Historical Note
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF6C5CE7),
                ),
              ),
              child: AppWidgets.buildCompanyInfo(child: (contents) {
                final data = contents.isNotEmpty ? contents[0] : {};
                return AppWidgets.buildHistoryCard(
                  content:
                      data['historicalNote'] ?? 'No historical note available.',
                );
              }),
            ),
          ),

          // Bottom Spacing
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 30),
          ),
        ],
      ),
    );
  }
}
