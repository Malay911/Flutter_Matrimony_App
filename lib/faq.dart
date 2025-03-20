import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        // AppBar with gradient inspired by StatisticsPage
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.shade400,
                  Colors.redAccent.shade700,
                ],
              ),
            ),
          ),
          title: Text(
            'FAQs',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
          ),
        ),

        // Body with subtle gradient background
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.redAccent.shade100.withOpacity(0.2),
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Header Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Frequently Asked Questions',
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Find answers to common queries about our matrimony app.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // FAQ Items
                _buildFAQItem(
                  question: 'How do I create a profile?',
                  answer:
                  'To create a profile, sign up with your email or phone number, then follow the profile creation wizard to add your personal details, preferences, and photos.',
                ),
                _buildFAQItem(
                  question: 'Is my information secure?',
                  answer:
                  'Yes, we use advanced encryption to protect your data. You can also control who sees your profile through privacy settings.',
                ),
                _buildFAQItem(
                  question: 'What are premium features?',
                  answer:
                  'Premium features include unlimited messaging, profile boosts, and access to advanced filters. Check the Subscription page for more details.',
                ),
                _buildFAQItem(
                  question: 'How do I verify my account?',
                  answer:
                  'Go to the Verification page in Settings, upload a valid ID proof, and take a selfie. Our team will review it within 24 hours.',
                ),
                _buildFAQItem(
                  question: 'Can I chat with matches directly?',
                  answer:
                  'Yes, once both users express mutual interest, you can start chatting through the in-app messaging feature.',
                ),

                // Contact Support Button
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to support page or open chat
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contacting Support...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Contact Support',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom FAQ Item Widget with ExpansionTile
  Widget _buildFAQItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        childrenPadding: const EdgeInsets.all(20),
        leading: Icon(
          Icons.help_outline,
          color: Colors.redAccent.shade700,
          size: 28,
        ),
        title: Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.redAccent.shade100.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        iconColor: Colors.redAccent.shade700,
        children: [
          Text(
            answer,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}