import 'package:fdag/utils/constants/app_constants.dart';
import 'package:fdag/utils/device/device_helper.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(constraints),
                    const SizedBox(height: 24),
                    _buildLastUpdated(constraints),
                    const SizedBox(height: 24),
                    _buildPolicyContent(constraints),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
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
          const Icon(
            Icons.privacy_tip,
            size: 40,
            color: Color(0xFF2196F3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This Privacy Policy describes how FDAG collects, uses, and protects your personal information.',
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

  Widget _buildLastUpdated(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Last Updated: December 21, 2024',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildPolicyContent(BoxConstraints constraints) {
    return Column(
      children: [
        _buildPolicySection(
          constraints: constraints,
          title: '1. Information We Collect',
          content: _buildCollectedInfo(),
        ),
        const SizedBox(height: 24),
        _buildPolicySection(
          constraints: constraints,
          title: '2. How We Use Your Information',
          content: _buildInformationUsage(),
        ),
        const SizedBox(height: 24),
        _buildPolicySection(
          constraints: constraints,
          title: '3. Information Sharing',
          content: _buildInformationSharing(),
        ),
        const SizedBox(height: 24),
        _buildPolicySection(
          constraints: constraints,
          title: '4. Data Security',
          content: _buildDataSecurity(),
        ),
        const SizedBox(height: 24),
        _buildPolicySection(
          constraints: constraints,
          title: '5. Your Rights',
          content: _buildUserRights(),
        ),
        const SizedBox(height: 24),
        _buildContact(constraints),
      ],
    );
  }

  Widget _buildPolicySection({
    required BoxConstraints constraints,
    required String title,
    required Widget content,
  }) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildCollectedInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Personal Information:',
          'Name, email address, phone number, and professional details',
        ),
        _buildBulletPoint(
          'Account Information:',
          'Login credentials and account preferences',
        ),
        _buildBulletPoint(
          'Usage Data:',
          'How you interact with our services and application',
        ),
        _buildBulletPoint(
          'Device Information:',
          'Device type, operating system, and browser information',
        ),
      ],
    );
  }

  Widget _buildInformationUsage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Service Provision:',
          'To provide and maintain our services',
        ),
        _buildBulletPoint(
          'Communication:',
          'To send updates, newsletters, and important notifications',
        ),
        _buildBulletPoint(
          'Improvement:',
          'To analyze and improve our services and user experience',
        ),
        _buildBulletPoint(
          'Legal Compliance:',
          'To comply with legal obligations and resolve disputes',
        ),
      ],
    );
  }

  Widget _buildInformationSharing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Service Providers:',
          'We may share information with trusted service providers',
        ),
        _buildBulletPoint(
          'Legal Requirements:',
          'We may disclose information when required by law',
        ),
        _buildBulletPoint(
          'Business Transfers:',
          'Information may be transferred in case of business merger or acquisition',
        ),
      ],
    );
  }

  Widget _buildDataSecurity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Security Measures:',
          'We implement appropriate technical and organizational security measures',
        ),
        _buildBulletPoint(
          'Data Protection:',
          'Regular security assessments and data protection reviews',
        ),
        _buildBulletPoint(
          'Access Control:',
          'Strict access controls and authentication procedures',
        ),
      ],
    );
  }

  Widget _buildUserRights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint(
          'Access:',
          'Right to access your personal information',
        ),
        _buildBulletPoint(
          'Correction:',
          'Right to correct inaccurate information',
        ),
        _buildBulletPoint(
          'Deletion:',
          'Right to request deletion of your information',
        ),
        _buildBulletPoint(
          'Objection:',
          'Right to object to processing of your information',
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF2196F3),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
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

  Widget _buildContact(BoxConstraints constraints) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        minHeight: 100,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'If you have any questions about this Privacy Policy, please contact us:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactButton(
            icon: Icons.email,
            label: 'privacy@fdag.org',
            onTap: () => _launchEmail(),
          ),
          const SizedBox(height: 12),
          _buildContactButton(
            icon: Icons.phone,
            label: '+233 XX XXX XXXX',
            onTap: () => _launchPhone(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF2196F3)),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2196F3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchEmail() {
    DeviceHelper.sendEmail(AppConstants.email, context);
  }

  void _launchPhone() {
    DeviceHelper.callPhone(AppConstants.phoneNumber, context);
  }
}
