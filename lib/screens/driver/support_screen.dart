import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How do I go online?',
      'answer': 'You can go online from the Driver Home screen by tapping the "Go Online" button. Ensure your vehicle documents are approved.',
    },
    {
      'question': 'How are my earnings calculated?',
      'answer': 'Earnings are calculated based on distance, time, and any surge pricing. You can view a detailed breakdown in the Earnings section.',
    },
    {
      'question': 'What if a passenger cancels?',
      'answer': 'If a passenger cancels after you\'ve accepted the ride, you may be eligible for a cancellation fee. Refer to our cancellation policy for details.',
    },
    {
      'question': 'How do I update my vehicle information?',
      'answer': 'You can update your vehicle details in the Vehicle Management section of your profile. All changes require approval.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqs.length,
              itemBuilder: (context, index) {
                final faq = _faqs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      faq['question']!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          faq['answer']!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[700],
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Contact Support',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.green),
                    title: const Text('Call Us'),
                    subtitle: const Text('+251 9XX XXX XXX'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: '+251912345678', // Replace with actual number
                      );
                      if (await canLaunchUrl(launchUri)) {
                        await launchUrl(launchUri);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch phone dialer')),
                        );
                      }
                    },
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.blue),
                    title: const Text('Email Us'),
                    subtitle: const Text('support@luxelift.com'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'mailto',
                        path: 'support@luxelift.com',
                        queryParameters: {
                          'subject': 'Support Request',
                          'body': 'Hello LuxeLift Support Team,',
                        },
                      );
                      if (await canLaunchUrl(launchUri)) {
                        await launchUrl(launchUri);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch email client')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
