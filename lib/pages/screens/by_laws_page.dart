import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BylawsPage extends StatefulWidget {
  const BylawsPage({Key? key}) : super(key: key);

  @override
  State<BylawsPage> createState() => _BylawsPageState();
}

class _BylawsPageState extends State<BylawsPage> {
  final List<BylawSection> _bylawSections = [
    BylawSection(
      title: 'Article 1: Organization',
      icon: 'assets/icons/organization.svg',
      subsections: [
        BylawSubsection(
          title: '1.1 Name and Purpose',
          content:
              'The name of this organization shall be the Fashion Designers Association...',
        ),
        BylawSubsection(
          title: '1.2 Mission Statement',
          content:
              'To promote excellence in fashion design and support emerging talents...',
        ),
      ],
    ),
    BylawSection(
      title: 'Article 2: Membership',
      icon: 'assets/icons/membership.svg',
      subsections: [
        BylawSubsection(
          title: '2.1 Eligibility',
          content: 'Membership is open to professional fashion designers...',
        ),
        BylawSubsection(
          title: '2.2 Categories',
          content:
              'The association shall have the following membership categories...',
        ),
      ],
    ),
    // Add more sections as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF6C5CE7),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Pattern
                  // SvgPicture.asset(
                  //   'assets/pattern.svg',
                  //   fit: BoxFit.cover,
                  // ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF6C5CE7).withAlpha(50),
                          const Color(0xFF6C5CE7),
                        ],
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Association Bylaws',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last Updated: December 2024',
                          style: TextStyle(
                            color: Colors.white.withAlpha(50),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withAlpha(50),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(50),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Implement search functionality
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(50),
                  child: IconButton(
                    icon: const Icon(Icons.download_outlined,
                        color: Colors.white),
                    onPressed: () {
                      // Implement PDF download
                    },
                  ),
                ),
              ),
            ],
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.picture_as_pdf,
                      title: 'Download PDF',
                      subtitle: 'Full Document',
                      onTap: () {
                        // Handle PDF download
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.share,
                      title: 'Share',
                      subtitle: 'Share Bylaws',
                      onTap: () {
                        // Handle sharing
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bylaws Content
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final section = _bylawSections[index];
                return _BylawSectionCard(section: section);
              },
              childCount: _bylawSections.length,
            ),
          ),
        ],
      ),

      // FAB for quick navigation
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C5CE7),
        child: const Icon(Icons.list),
        onPressed: () {
          // Show table of contents bottom sheet
          _showTableOfContents(context);
        },
      ),
    );
  }

  void _showTableOfContents(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Table of Contents',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _bylawSections.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.article, color: Color(0xFF6C5CE7)),
                    title: Text(_bylawSections[index].title),
                    onTap: () {
                      Navigator.pop(context);
                      // Scroll to section
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF6C5CE7), size: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BylawSectionCard extends StatelessWidget {
  final BylawSection section;

  const _BylawSectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: SvgPicture.asset(
            section.icon,
            width: 24,
            height: 24,
            // color: const Color(0xFF6C5CE7),
          ),
          title: Text(
            section.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children: section.subsections.map((subsection) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subsection.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subsection.content,
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BylawSection {
  final String title;
  final String icon;
  final List<BylawSubsection> subsections;

  BylawSection({
    required this.title,
    required this.icon,
    required this.subsections,
  });
}

class BylawSubsection {
  final String title;
  final String content;

  BylawSubsection({
    required this.title,
    required this.content,
  });
}
