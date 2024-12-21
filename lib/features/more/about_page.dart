import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About FDAG'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  minHeight: constraints.minHeight,
                ),
                child: Column(
                  children: [
                    _buildHeaderImage(constraints),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMissionVision(constraints),
                          const SizedBox(height: 24),
                          _buildHistory(constraints),
                          const SizedBox(height: 24),
                          _buildLeadership(constraints),
                          const SizedBox(height: 24),
                          _buildAchievements(constraints),
                          const SizedBox(height: 24),
                          _buildSocialLinks(constraints),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxWidth * 0.5, // Aspect ratio control
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5), // Solid color instead of opacity
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/logo.jpg', // Add your image
            width: double.infinity,
            height: constraints.maxWidth * 0.5,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: constraints.maxWidth * 0.5,
            color: const Color(0x88000000), // Solid color with alpha
            padding: const EdgeInsets.all(16),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fashion Designers Association of Ghana',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Empowering Fashion Excellence Since 1980',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionVision(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'To promote and develop the Ghanaian fashion industry through professional excellence, innovation, and sustainable practices.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Our Vision',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'To establish Ghana as a global fashion hub, celebrating our rich cultural heritage while embracing modern design perspectives.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistory(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          AppWidgets.buildTimelineItem(
            year: '1980',
            title: 'Foundation',
            description:
                'FDAG was established by a group of visionary fashion designers.',
            constraints: constraints,
            context: context,
          ),
          AppWidgets.buildTimelineItem(
            year: '1995',
            title: 'National Recognition',
            description:
                'Received official recognition as the premier fashion organization in Ghana.',
            constraints: constraints,
            context: context,
          ),
          AppWidgets.buildTimelineItem(
            year: '2010',
            title: 'International Expansion',
            description:
                'Began collaborating with international fashion organizations.',
            constraints: constraints,
            context: context,
          ),
          AppWidgets.buildTimelineItem(
            year: '2023',
            title: 'Digital Transformation',
            description:
                'Launched digital platforms and modern training programs.',
            constraints: constraints,
            context: context,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLeadership(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Leadership',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildLeadershipGrid(constraints),
        ],
      ),
    );
  }

  Widget _buildLeadershipGrid(BoxConstraints constraints) {
    final leaders = [
      {'name': 'Sarah Mensah', 'role': 'President'},
      {'name': 'Kwame Addo', 'role': 'Vice President'},
      {'name': 'Abena Osei', 'role': 'Secretary'},
      {'name': 'John Kufuor', 'role': 'Treasurer'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: leaders.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFE0E0E0),
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                leaders[index]['name']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                leaders[index]['role']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievements(BoxConstraints constraints) {
    final achievements = [
      'Over 1000+ active members nationwide',
      'Annual Ghana Fashion Week organization',
      'International partnerships with leading fashion institutions',
      'Youth training and mentorship programs',
    ];

    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...achievements.map((achievement) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        achievement,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 80,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connect With Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppWidgets.buildSocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                onTap: () => _launchSocialMedia('facebook'),
              ),
              AppWidgets.buildSocialButton(
                icon: Icons.camera_alt,
                label: 'Instagram',
                onTap: () => _launchSocialMedia('instagram'),
              ),
              AppWidgets.buildSocialButton(
                icon: Icons.web,
                label: 'Website',
                onTap: () => _launchSocialMedia('website'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchSocialMedia(String platform) {
    // Implement social media launch logic
  }
}
