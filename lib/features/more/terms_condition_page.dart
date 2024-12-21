import 'package:fdag/utils/constants/app_constants.dart';
import 'package:fdag/utils/device/device_helper.dart';
import 'package:flutter/material.dart';

class TermsConditionPage extends StatefulWidget {
  const TermsConditionPage({super.key});

  @override
  State<TermsConditionPage> createState() => _TermsConditionPageState();
}

class _TermsConditionPageState extends State<TermsConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
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
                    _buildTermsContent(constraints),
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
            Icons.gavel,
            size: 40,
            color: Color(0xFF2196F3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please read these terms and conditions carefully before using the FDAG application.',
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

  Widget _buildTermsContent(BoxConstraints constraints) {
    return Column(
      children: [
        _buildSection(
          constraints: constraints,
          title: '1. Acceptance of Terms',
          content: _buildAcceptanceTerms(),
        ),
        const SizedBox(height: 24),
        _buildSection(
          constraints: constraints,
          title: '2. Membership Terms',
          content: _buildMembershipTerms(),
        ),
        const SizedBox(height: 24),
        _buildSection(
          constraints: constraints,
          title: '3. User Responsibilities',
          content: _buildUserResponsibilities(),
        ),
        const SizedBox(height: 24),
        _buildSection(
          constraints: constraints,
          title: '4. Intellectual Property',
          content: _buildIntellectualProperty(),
        ),
        const SizedBox(height: 24),
        _buildSection(
          constraints: constraints,
          title: '5. Payment Terms',
          content: _buildPaymentTerms(),
        ),
        const SizedBox(height: 24),
        _buildSection(
          constraints: constraints,
          title: '6. Termination',
          content: _buildTermination(),
        ),
        const SizedBox(height: 24),
        _buildSection(
          constraints: constraints,
          title: '7. Limitation of Liability',
          content: _buildLiabilityLimitation(),
        ),
        const SizedBox(height: 24),
        _buildContact(constraints),
      ],
    );
  }

  Widget _buildSection({
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

  Widget _buildAcceptanceTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'By accessing or using the FDAG application, you agree to be bound by these terms and conditions. If you disagree with any part of these terms, you may not access the application.',
        ),
        _buildBulletPoint(
          'Agreement to all terms and conditions stated herein',
        ),
        _buildBulletPoint(
          'Acknowledgment of FDAG\'s right to modify terms',
        ),
        _buildBulletPoint(
          'Acceptance of electronic communication as official notice',
        ),
      ],
    );
  }

  Widget _buildMembershipTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'Membership in FDAG is subject to the following terms:',
        ),
        _buildBulletPoint(
          'Annual membership fees must be paid in full',
        ),
        _buildBulletPoint(
          'Members must maintain professional standards',
        ),
        _buildBulletPoint(
          'Membership benefits are non-transferable',
        ),
        _buildBulletPoint(
          'Compliance with FDAG code of conduct',
        ),
      ],
    );
  }

  Widget _buildUserResponsibilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'Users of the FDAG application are responsible for:',
        ),
        _buildBulletPoint(
          'Maintaining accurate and up-to-date account information',
        ),
        _buildBulletPoint(
          'Protecting account credentials and security',
        ),
        _buildBulletPoint(
          'Complying with all applicable laws and regulations',
        ),
        _buildBulletPoint(
          'Respecting intellectual property rights',
        ),
      ],
    );
  }

  Widget _buildIntellectualProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'All content and materials available in the FDAG application are protected by intellectual property rights:',
        ),
        _buildBulletPoint(
          'FDAG owns all proprietary content and materials',
        ),
        _buildBulletPoint(
          'Users may not reproduce or distribute content without permission',
        ),
        _buildBulletPoint(
          'Trademarks and logos are protected property',
        ),
      ],
    );
  }

  Widget _buildPaymentTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'Payment terms for FDAG services include:',
        ),
        _buildBulletPoint(
          'All fees are non-refundable unless stated otherwise',
        ),
        _buildBulletPoint(
          'Payment must be made through approved methods',
        ),
        _buildBulletPoint(
          'Late payments may result in service suspension',
        ),
      ],
    );
  }

  Widget _buildTermination() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'FDAG reserves the right to terminate or suspend accounts:',
        ),
        _buildBulletPoint(
          'For violation of these terms and conditions',
        ),
        _buildBulletPoint(
          'For engaging in fraudulent or illegal activities',
        ),
        _buildBulletPoint(
          'For non-payment of fees',
        ),
      ],
    );
  }

  Widget _buildLiabilityLimitation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'FDAG\'s liability is limited as follows:',
        ),
        _buildBulletPoint(
          'Not liable for indirect or consequential damages',
        ),
        _buildBulletPoint(
          'No warranty for uninterrupted or error-free service',
        ),
        _buildBulletPoint(
          'Maximum liability limited to fees paid',
        ),
      ],
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
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
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
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
            'Questions About Terms?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'If you have any questions about these Terms & Conditions, please contact us:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactButton(
            icon: Icons.email,
            label: 'legal@fdag.org',
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
