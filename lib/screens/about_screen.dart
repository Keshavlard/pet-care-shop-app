import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart'; // Create this next

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome to Pet Care Shop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pet Care Shop is a comprehensive app designed to make your pet parenting journey easier and more joyful. Whether you own a dog, cat, bird, fish, or rabbit — we’ve got something for you!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              '✨ Key Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Shop high-quality pet products\n'
                  '• Locate nearby veterinary hospitals\n'
                  '• User-friendly interface for quick navigation\n'
                  '• Regular updates with new features\n',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              ' Version : 1.0',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0x5240C4FF),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.privacy_tip),
                label: const Text('View Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
