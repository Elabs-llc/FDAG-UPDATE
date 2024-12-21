import 'package:fdag/commons/widgets/app_widgets.dart';
import 'package:fdag/features/more/faq_data.dart';
import 'package:fdag/utils/constants/app_constants.dart';
import 'package:fdag/utils/device/device_helper.dart';
import 'package:flutter/material.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildContactSection(context, constraints),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Frequently Asked Questions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppWidgets.buildFAQCategory(
                          constraints: constraints,
                          title: 'Membership',
                          icon: Icons.card_membership,
                          faqs: membershipFAQs,
                        ),
                        const SizedBox(height: 16),
                        AppWidgets.buildFAQCategory(
                          constraints: constraints,
                          title: 'Events',
                          icon: Icons.event,
                          faqs: eventsFAQs,
                        ),
                        const SizedBox(height: 16),
                        AppWidgets.buildFAQCategory(
                          constraints: constraints,
                          title: 'Training',
                          icon: Icons.school,
                          faqs: trainingFAQs,
                        ),
                        const SizedBox(height: 16),
                        AppWidgets.buildFAQCategory(
                          constraints: constraints,
                          title: 'Support',
                          icon: Icons.help,
                          faqs: supportFAQs,
                        ),
                      ],
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

  Widget _buildContactSection(
      BuildContext context, BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Support',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AppWidgets.buildContactCard(
          context,
          constraints: constraints,
          icon: Icons.email,
          title: 'Email Support',
          subtitle: 'Get help via email',
          onTap: () => _launchEmail(),
        ),
        const SizedBox(height: 12),
        AppWidgets.buildContactCard(
          context,
          constraints: constraints,
          icon: Icons.phone,
          title: 'Phone Support',
          subtitle: 'Talk to our team',
          onTap: () => _launchPhone(),
        ),
        const SizedBox(height: 12),
        AppWidgets.buildContactCard(
          context,
          constraints: constraints,
          icon: Icons.chat_bubble,
          title: 'Live Chat',
          subtitle: 'Chat with support team',
          onTap: () => _openLiveChat(context),
        ),
      ],
    );
  }

  void _launchEmail() {
    DeviceHelper.sendEmail(AppConstants.email, context);
  }

  void _launchPhone() {
    DeviceHelper.callPhone(AppConstants.phoneNumber, context);
  }

  void _openLiveChat(BuildContext context) {
    DeviceHelper.openWhatsApp(AppConstants.phoneNumber,
        "Hello, I’m reaching out regarding a business inquiry. Please let me know how we can connect further.");
  }
}
