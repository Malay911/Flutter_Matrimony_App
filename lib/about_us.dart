import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.redAccent[400], size: 20),
              onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
          ),
        ),
        body: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
              painter: BackgroundPatternPainter(),
            ),

            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red.shade200, Colors.red.shade100],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.shade100.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),

            // Wave Pattern
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 100),
                painter: WavePainter(color: Colors.red.shade100.withOpacity(0.3)),
              ),
            ),

            // Floating Hearts
            ...List.generate(15, (index) {
              return Positioned(
                left: (index * 50.0) % MediaQuery.of(context).size.width,
                top: (index * 100.0) % MediaQuery.of(context).size.height,
                child: Icon(
                  Icons.favorite,
                  size: 20 + (index % 3) * 5,
                  color: Colors.red.shade200.withOpacity(0.3),
                ),
              );
            }),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero Section
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.redAccent[400]!, Colors.red.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Enhanced Hero Background Pattern
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width, 300),
                            painter: HeroPatternPainter(),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/logo2.png',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Matrimony',
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Content Section (remaining content stays the same)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildCard(
                            title: 'Meet Our Team',
                            content: Column(
                              children: [
                                _buildInfoRow('👨‍💻 Developer', 'Malay Panara'),
                                _buildInfoRow(
                                    '👨‍🏫 Mentor', 'Prof. Mehul Bhundiya'),
                                _buildInfoRow(
                                    '🏛️ Department', 'Computer Engineering'),
                                _buildInfoRow(
                                    '🎓 Institution', 'Darshan University'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildCard(
                            title: 'About ASWDC',
                            content: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/images/darshanlogo.png',
                                    height: 92,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'ASWDC is Application, Software and Website Development Center @ Darshan University, bridging the gap between academia and industry through hands-on experience and expert guidance.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildCard(
                            title: 'Get in Touch',
                            content: Column(
                              children: [
                                _buildContactItem(
                                    Icons.email_outlined, 'aswdc@darshan.ac.in'),
                                _buildContactItem(
                                    Icons.phone_outlined, '+91-9727747317'),
                                _buildContactItem(
                                    Icons.language_outlined, 'www.darshan.ac.in'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildCard(
                            title: 'Quick Links',
                            content: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _buildActionChip(Icons.share_outlined, 'Share'),
                                _buildActionChip(Icons.star_outline, 'Rate Us'),
                                _buildActionChip(
                                    Icons.facebook_outlined, 'Follow Us'),
                                _buildActionChip(Icons.update_outlined, 'Update'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style:
                                  TextStyle(color: Colors.black54, height: 1.5),
                              children: [
                                TextSpan(text: '© 2025 Darshan University\n'),
                                TextSpan(text: 'Made with '),
                                WidgetSpan(
                                  child: Icon(Icons.favorite,
                                      color: Colors.red, size: 14),
                                ),
                                TextSpan(text: ' in India'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods remain the same
  Widget _buildCard({required String title, required Widget content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent[400],
              ),
            ),
            const Divider(height: 25),
            content,
          ],
        ),
      ),
    );
  }

// Other helper methods remain the same...
}

// Custom Painter for background pattern
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.shade100.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < size.height; i += 50) {
      for (var j = 0; j < size.width; j += 50) {
        canvas.drawCircle(Offset(j.toDouble(), i.toDouble()), 10, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (var i = 0.0; i < size.width; i += 50) {
      path.quadraticBezierTo(i + 25, size.height - 20, i + 50, size.height);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HeroPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < size.width; i += 30) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble() + 15, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget _buildContactItem(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.redAccent[400], size: 20),
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black54),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionChip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.redAccent[400]),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: Colors.redAccent[400]),
        ),
      ],
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AboutUsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.9),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.redAccent[400], size: 20),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.red.shade50,
//               Colors.white,
//               Colors.red.shade50,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Hero Section
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.redAccent[400]!, Colors.red.shade300],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(40),
//                     bottomRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Background pattern
//                     Positioned(
//                       right: -50,
//                       top: -50,
//                       child: Container(
//                         width: 200,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white.withOpacity(0.1),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: ClipOval(
//                             child: Image.asset(
//                               'assets/images/logo2.png',
//                               height: 120,
//                               width: 120,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           'Matrimony',
//                           style: GoogleFonts.poppins(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     // Team Card
//                     _buildCard(
//                       title: 'Meet Our Team',
//                       content: Column(
//                         children: [
//                           _buildInfoRow('👨‍💻 Developer', 'Malay Panara'),
//                           _buildInfoRow('👨‍🏫 Mentor', 'Prof. Mehul Bhundiya'),
//                           _buildInfoRow('🏛️ Department', 'Computer Engineering'),
//                           _buildInfoRow('🎓 Institution', 'Darshan University'),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // About ASWDC Card
//                     _buildCard(
//                       title: 'About ASWDC',
//                       content: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Image.asset(
//                               'assets/images/darshanlogo.png',
//                               height: 85,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(height: 15),
//                           Text(
//                             'ASWDC is Application, Software and Website Development Center @ Darshan University, bridging the gap between academia and industry through hands-on experience and expert guidance.',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.black87,
//                               height: 1.5,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Contact Card
//                     _buildCard(
//                       title: 'Get in Touch',
//                       content: Column(
//                         children: [
//                           _buildContactItem(Icons.email_outlined, 'aswdc@darshan.ac.in'),
//                           _buildContactItem(Icons.phone_outlined, '+91-9727747317'),
//                           _buildContactItem(Icons.language_outlined, 'www.darshan.ac.in'),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Quick Links
//                     _buildCard(
//                       title: 'Quick Links',
//                       content: Wrap(
//                         spacing: 10,
//                         runSpacing: 10,
//                         children: [
//                           _buildActionChip(Icons.share_outlined, 'Share'),
//                           _buildActionChip(Icons.star_outline, 'Rate Us'),
//                           _buildActionChip(Icons.facebook_outlined, 'Follow Us'),
//                           _buildActionChip(Icons.update_outlined, 'Update'),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 30),
//
//                     // Footer
//                     RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                         style: TextStyle(color: Colors.black54, height: 1.5),
//                         children: [
//                           TextSpan(text: '© 2025 Darshan University\n'),
//                           TextSpan(text: 'Made with '),
//                           WidgetSpan(
//                             child: Icon(Icons.favorite, color: Colors.red, size: 14),
//                           ),
//                           TextSpan(text: ' in India'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({required String title, required Widget content}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 20,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.redAccent[400],
//               ),
//             ),
//             Divider(height: 25),
//             content,
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.black54),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactItem(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.red.shade50,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, color: Colors.redAccent[400], size: 20),
//           ),
//           SizedBox(width: 15),
//           Text(
//             text,
//             style: TextStyle(color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionChip(IconData icon, String label) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.red.shade50,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 18, color: Colors.redAccent[400]),
//           SizedBox(width: 8),
//           Text(
//             label,
//             style: TextStyle(color: Colors.redAccent[400]),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AboutUsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'About Us',
//           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent[400],
//         elevation: 5,
//         centerTitle: true,
//         leading: IconButton(
//           icon: AnimatedSwitcher(
//             duration: Duration(milliseconds: 300),
//             child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24, key: ValueKey('back_icon')),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//
//       body: Container(
//         // decoration: BoxDecoration(
//         //   gradient: LinearGradient(
//         //     colors: [Colors.red.shade50, Colors.red.shade100],
//         //     begin: Alignment.topLeft,
//         //     end: Alignment.bottomRight,
//         //   ),
//         // ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.red.shade50,
//               Colors.red.shade300,
//               // Colors.red.shade200,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Column(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.asset(
//                         'assets/images/logo2.png',
//                         fit: BoxFit.cover,
//                         height: 250,
//                         width: 250,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'Matrimony',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//
//                 // Meet Our Team Section
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 6,
//                   shadowColor: Colors.deepPurple.withOpacity(0.2),
//                   color: Colors.white.withOpacity(0.8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Meet Our Team',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                         Divider(color: Colors.black),
//                         buildKeyValueRow('Developed by', 'Malay Panara (23010101184)'),
//                         buildKeyValueRow('Mentored by',
//                             'Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science'),
//                         buildKeyValueRow(
//                             'Explored by', 'ASWDC, School Of Computer Science, School of Computer Science'),
//                         buildKeyValueRow(
//                             'Eulogized by', 'Darshan University, Rajkot, Gujarat - INDIA'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//
//                 // About ASWDC Section
//                 // Card(
//                 //   shape: RoundedRectangleBorder(
//                 //     borderRadius: BorderRadius.circular(16),
//                 //   ),
//                 //   elevation: 6,
//                 //   shadowColor: Colors.deepPurple.withOpacity(0.2),
//                 //   color: Colors.white.withOpacity(0.8),
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.all(16.0),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         Text(
//                 //           'About ASWDC',
//                 //           style: TextStyle(
//                 //             fontSize: 20,
//                 //             fontWeight: FontWeight.w600,
//                 //             color: Colors.redAccent,
//                 //           ),
//                 //         ),
//                 //         Divider(color: Colors.black),
//                 //         Row(
//                 //           children: [
//                 //             Expanded(
//                 //               child: ClipRRect(
//                 //                 borderRadius: BorderRadius.circular(12),
//                 //                 child: Image.asset(
//                 //                   'assets/images/darshanlogo.png',
//                 //                   fit: BoxFit.cover,
//                 //                 ),
//                 //               ),
//                 //             ),
//                 //             SizedBox(width: 16),
//                 //             // Expanded(
//                 //             //   child: ClipRRect(
//                 //             //     borderRadius: BorderRadius.circular(12),
//                 //             //     child: Image.asset(
//                 //             //       'assets/images/aswdc.png',
//                 //             //       fit: BoxFit.cover,
//                 //             //     ),
//                 //             //   ),
//                 //             // ),
//                 //           ],
//                 //         ),
//                 //         SizedBox(height: 8),
//                 //         Text(
//                 //           'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
//                 //           style: TextStyle(fontSize: 14, color: Colors.black87),
//                 //         ),
//                 //         SizedBox(height: 8),
//                 //         Text(
//                 //           'The sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications & experience a professional environment @ ASWDC under the guidance of industry experts & faculty members.',
//                 //           style: TextStyle(fontSize: 14, color: Colors.black87),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//
//                 // About ASWDC Section
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 6,
//                   shadowColor: Colors.deepPurple.withOpacity(0.2),
//                   color: Colors.white.withOpacity(0.8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'About ASWDC',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                         Divider(color: Colors.black),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.asset(
//                                   'assets/images/darshanlogo.png',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             // Expanded(
//                             //   child: ClipRRect(
//                             //     borderRadius: BorderRadius.circular(12),
//                             //     child: Image.asset(
//                             //       'assets/images/aswdc.png',
//                             //       fit: BoxFit.cover,
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'The sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications & experience a professional environment @ ASWDC under the guidance of industry experts & faculty members.',
//                           style: TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//
//                 // Contact Us Section
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 6,
//                   shadowColor: Colors.deepPurple.withOpacity(0.2),
//                   color: Colors.white.withOpacity(0.8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Contact Us',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                         Divider(color: Colors.black),
//                         buildContactRow(Icons.email, 'aswdc@darshan.ac.in'),
//                         buildContactRow(Icons.phone, '+91-9727747317'),
//                         buildContactRow(Icons.language, 'www.darshan.ac.in'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//
//                 // Other Links Section
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 6,
//                   shadowColor: Colors.deepPurple.withOpacity(0.2),
//                   color: Colors.white.withOpacity(0.8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         buildLinkRow(Icons.share, 'Share App'),
//                         buildLinkRow(Icons.apps, 'More Apps'),
//                         buildLinkRow(Icons.star, 'Rate Us'),
//                         buildLinkRow(Icons.thumb_up, 'Like us on Facebook'),
//                         buildLinkRow(Icons.update, 'Check For Update'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//
//                 // Footer Section
//                 Center(
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: '© 2025 Darshan University\nAll Rights Reserved - Privacy Policy\nMade with ',
//                       style: const TextStyle(fontSize: 12, color: Colors.black54),
//                       children: [
//                         WidgetSpan(
//                           child: Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                             size: 14, // Adjust size to fit with text
//                           ),
//                         ),
//                         const TextSpan(
//                           text: ' in India',
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildKeyValueRow(String key, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(flex: 2, child: Text('$key: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
//           Expanded(flex: 3, child: Text(value, style: TextStyle(color: Colors.black54))),
//         ],
//       ),
//     );
//   }
//
//   Widget buildContactRow(IconData icon, String info) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.redAccent),
//           SizedBox(width: 8),
//           Text(info, style: TextStyle(color: Colors.black54)),
//         ],
//       ),
//     );
//   }
//
//   Widget buildLinkRow(IconData icon, String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.redAccent),
//           SizedBox(width: 8),
//           Text(title, style: TextStyle(color: Colors.black54)),
//         ],
//       ),
//     );
//   }
// }
