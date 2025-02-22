import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        backgroundColor: Colors.redAccent[400],
        elevation: 5,
        centerTitle: true,
        leading: IconButton(
          icon: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24, key: ValueKey('back_icon')),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.red.shade50, Colors.red.shade100],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade50,
              Colors.red.shade300,
              // Colors.red.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/logo2.png',
                        fit: BoxFit.cover,
                        height: 250,
                        width: 250,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Matrimony',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Meet Our Team Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.2),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meet Our Team',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),
                        ),
                        Divider(color: Colors.black),
                        buildKeyValueRow('Developed by', 'Malay Panara (23010101184)'),
                        buildKeyValueRow('Mentored by',
                            'Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science'),
                        buildKeyValueRow(
                            'Explored by', 'ASWDC, School Of Computer Science, School of Computer Science'),
                        buildKeyValueRow(
                            'Eulogized by', 'Darshan University, Rajkot, Gujarat - INDIA'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // About ASWDC Section
                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   elevation: 6,
                //   shadowColor: Colors.deepPurple.withOpacity(0.2),
                //   color: Colors.white.withOpacity(0.8),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'About ASWDC',
                //           style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.redAccent,
                //           ),
                //         ),
                //         Divider(color: Colors.black),
                //         Row(
                //           children: [
                //             Expanded(
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(12),
                //                 child: Image.asset(
                //                   'assets/images/darshanlogo.png',
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //             SizedBox(width: 16),
                //             // Expanded(
                //             //   child: ClipRRect(
                //             //     borderRadius: BorderRadius.circular(12),
                //             //     child: Image.asset(
                //             //       'assets/images/aswdc.png',
                //             //       fit: BoxFit.cover,
                //             //     ),
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //         SizedBox(height: 8),
                //         Text(
                //           'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
                //           style: TextStyle(fontSize: 14, color: Colors.black87),
                //         ),
                //         SizedBox(height: 8),
                //         Text(
                //           'The sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications & experience a professional environment @ ASWDC under the guidance of industry experts & faculty members.',
                //           style: TextStyle(fontSize: 14, color: Colors.black87),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // About ASWDC Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.2),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About ASWDC',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),
                        ),
                        Divider(color: Colors.black),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/darshanlogo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            // Expanded(
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(12),
                            //     child: Image.asset(
                            //       'assets/images/aswdc.png',
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'The sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications & experience a professional environment @ ASWDC under the guidance of industry experts & faculty members.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Contact Us Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.2),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),
                        ),
                        Divider(color: Colors.black),
                        buildContactRow(Icons.email, 'aswdc@darshan.ac.in'),
                        buildContactRow(Icons.phone, '+91-9727747317'),
                        buildContactRow(Icons.language, 'www.darshan.ac.in'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Other Links Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.2),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        buildLinkRow(Icons.share, 'Share App'),
                        buildLinkRow(Icons.apps, 'More Apps'),
                        buildLinkRow(Icons.star, 'Rate Us'),
                        buildLinkRow(Icons.thumb_up, 'Like us on Facebook'),
                        buildLinkRow(Icons.update, 'Check For Update'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Footer Section
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '© 2025 Darshan University\nAll Rights Reserved - Privacy Policy\nMade with ',
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 14, // Adjust size to fit with text
                          ),
                        ),
                        const TextSpan(
                          text: ' in India',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text('$key: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
          Expanded(flex: 3, child: Text(value, style: TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }

  Widget buildContactRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          SizedBox(width: 8),
          Text(info, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget buildLinkRow(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          SizedBox(width: 8),
          Text(title, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class AboutUsScreen extends StatelessWidget {
//   const AboutUsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About Us'),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.redAccent,
//                 Colors.deepOrangeAccent,
//                 Colors.pinkAccent
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           // Container(
//           //   width: double.infinity,
//           //   height: double.infinity,
//           //   decoration: BoxDecoration(
//           //     image: DecorationImage(
//           //       image: AssetImage('images/img_8.png'),
//           //       fit: BoxFit.cover,
//           //       opacity: 0.8,
//           //     ),
//           //   ),
//           // ),
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/img_8.png', // Make sure you have a suitable image here
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
//               child: Container(
//                 color: Colors.black.withOpacity(0.3),
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: Text(
//                     'Meet Our Team',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Developed by: Malay Panara (23010101184)\n'
//                           'Mentored by: Prof. Mehul Bhundiya\n'
//                           'Explored by: ASWDC\n'
//                           'Eulogized by: Darshan University, Rajkot, Gujarat - INDIA',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'About ASWDC',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.\n'
//                           'Sole purpose of ASWDC is to bridge gap between university curriculum & industry demands. Students learn cutting-edge technologies and develop real-world applications.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Contact Information',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.email, color: Colors.black),
//                     ),
//                     title: Text(
//                       'aswdc@darshan.ac.in',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.phone, color: Colors.black),
//                     ),
//                     title: Text(
//                       '+91-9727747317',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.web, color: Colors.black),
//                     ),
//                     title: Text(
//                       'www.darshan.ac.in',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Additional Options',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.share, color: Colors.black),
//                     ),
//                     title: Text(
//                       'Share the App',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.apps, color: Colors.black),
//                     ),
//                     title: Text(
//                       'Find More Apps',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.star, color: Colors.black),
//                     ),
//                     title: Text(
//                       'Rate the App',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.thumb_up, color: Colors.black),
//                     ),
//                     title: Text(
//                       'Like on Facebook',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.black54,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.update, color: Colors.black),
//                     ),
//                     title: Text(
//                       'Check for Updates',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20), // Add some space before the footer
//                 Center(
//                   child: Text(
//                     '© 2025 Darshan University. All rights reserved.',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Privacy Policy',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.blue,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Made with',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(width: 4),
//                     Icon(
//                       Icons.favorite,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       'in INDIA',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }