import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MissionVisionPage extends StatelessWidget {
  const MissionVisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Animated App Bar
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: const Color(0xFF6C5CE7),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Decorative Background
                  SvgPicture.asset(
                    'assets/icons/vision-pattern.svg',
                    fit: BoxFit.cover,
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color(0xFF6C5CE7),
                          const Color(0xFF574BC0).withAlpha(90),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(20),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Our Purpose',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Mission & Vision',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Shaping the future of fashion design',
                          style: TextStyle(
                            color: Colors.white.withAlpha(80),
                            fontSize: 16,
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
                backgroundColor: Colors.white.withAlpha(20),
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(20),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      // Implement share functionality
                    },
                  ),
                ),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Mission Section
                _buildSection(
                  title: 'Our Mission',
                  icon: 'assets/icons/mission.svg',
                  content:
                      'To empower and unite fashion designers through innovation, education, and collaboration, creating a vibrant community that pushes the boundaries of creative excellence.',
                  goals: [
                    'Foster innovation in fashion design',
                    'Provide educational opportunities',
                    'Build strong industry networks',
                    'Support sustainable practices',
                  ],
                ),

                // Vision Section
                _buildSection(
                  title: 'Our Vision',
                  icon: 'assets/icons/vision.svg',
                  content:
                      'To be the leading force in shaping the future of fashion design, creating a world where creativity, sustainability, and innovation converge to transform the industry.',
                  goals: [
                    'Global design leadership',
                    'Sustainable fashion future',
                    'Digital transformation',
                    'Industry inclusivity',
                  ],
                ),

                // Values Section
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(10),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Our Core Values',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildValueItem(
                        icon: Icons.brush,
                        title: 'Creativity',
                        description:
                            'Fostering innovative design thinking and artistic expression',
                      ),
                      _buildValueItem(
                        icon: Icons.eco,
                        title: 'Sustainability',
                        description:
                            'Promoting environmentally conscious design practices',
                      ),
                      _buildValueItem(
                        icon: Icons.people,
                        title: 'Collaboration',
                        description:
                            'Building strong partnerships within the fashion community',
                      ),
                      _buildValueItem(
                        icon: Icons.school,
                        title: 'Excellence',
                        description:
                            'Maintaining high standards in design and education',
                      ),
                    ],
                  ),
                ),

                // Strategic Goals
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Strategic Goals',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildGoalCard(
                        title: 'Digital Innovation',
                        subtitle:
                            'Embracing technology to transform fashion design',
                        progress: 0.75,
                        color: const Color(0xFF6C5CE7),
                      ),
                      _buildGoalCard(
                        title: 'Global Expansion',
                        subtitle: 'Building international design networks',
                        progress: 0.60,
                        color: const Color(0xFF00B894),
                      ),
                      _buildGoalCard(
                        title: 'Sustainable Practice',
                        subtitle: 'Promoting eco-friendly fashion solutions',
                        progress: 0.85,
                        color: const Color(0xFFFF7675),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String icon,
    required String content,
    required List<String> goals,
  }) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(10),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFF636E72),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: goals.map((goal) {
              return Chip(
                label: Text(goal),
                backgroundColor: const Color(0xFF6C5CE7).withAlpha(10),
                labelStyle: const TextStyle(
                  color: Color(0xFF6C5CE7),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withAlpha(10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6C5CE7),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required String title,
    required String subtitle,
    required double progress,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(10),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withAlpha(10),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
