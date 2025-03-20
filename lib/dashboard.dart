// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login_screen.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   String userName = 'Guest';
//   String userEmail = 'guest@example.com';
//   String userPhotoUrl = "assets/images/image.png";
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userName = prefs.getString('userName') ?? 'Guest';
//       userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
//       userPhotoUrl = prefs.getString('userPhoto') ?? "assets/images/image.png";
//     });
//   }
//
//   Future<void> _logout(BuildContext context) async {
//     bool? shouldLogout = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Are you sure you want to logout?"),
//           content: const Text("You will be logged out of the app."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text("No"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 await prefs.setBool('isLoggedIn', false);
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//               child: const Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('True Companion',
//             style: GoogleFonts.poppins(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white)),
//         backgroundColor: Colors.redAccent[400],
//         leading: IconButton(
//           color: Colors.white,
//           icon: const Icon(Icons.menu_open_rounded),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         centerTitle: true,
//         elevation: 5,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: PopupMenuButton<int>(
//               onSelected: (value) {
//                 if (value == 1) {
//                   _logout(context);
//                 }
//               },
//               child: CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage(userPhotoUrl),
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem<int>(
//                   value: 1,
//                   child: Row(
//                     children: [
//                       const Icon(Icons.logout, color: Colors.redAccent),
//                       const SizedBox(width: 10),
//                       Text("Logout", style: GoogleFonts.poppins()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       drawer: SizedBox(
//         width: 280,
//         child: Drawer(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.white, Colors.red.shade50],
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 30),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.redAccent, Colors.red.shade600],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 3),
//                         ),
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundImage: AssetImage(userPhotoUrl),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Text(
//                         userName,
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         userEmail,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildDrawerItem(
//                   icon: Icons.home_rounded,
//                   title: "Home",
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 // _buildDrawerItem(
//                 //   icon: Icons.people_rounded,
//                 //   title: "User List",
//                 //   onTap: () => Navigator.pushNamed(context, '/userList'),
//                 // ),
//                 // _buildDrawerItem(
//                 //   icon: Icons.favorite_rounded,
//                 //   title: "Favourites",
//                 //   onTap: () => Navigator.pushNamed(context, '/favourites'),
//                 // ),
//                 _buildDrawerItem(
//                   icon: Icons.info_rounded,
//                   title: "About Us",
//                   onTap: () => Navigator.pushNamed(context, '/aboutUs'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.bar_chart_rounded,
//                   title: "Statistics",
//                   onTap: () => Navigator.pushNamed(context, '/statistics'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.bar_chart_rounded,
//                   title: "FAQs",
//                   onTap: () => Navigator.pushNamed(context, '/faq'),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: ElevatedButton.icon(
//                     onPressed: () => _logout(context),
//                     icon: const Icon(Icons.logout_rounded, color: Colors.white),
//                     label: Text(
//                       "Logout",
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.redAccent,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.redAccent.shade400],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 20.0, horizontal: 20.0),
//                 child: Text(
//                   'Welcome to True Companion Matrimony',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                     letterSpacing: 1.2,
//                     height: 1.5,
//                     shadows: [
//                       Shadow(
//                         offset: const Offset(2, 2),
//                         blurRadius: 3,
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Text(
//                   'Find Your Perfect Match',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey.shade600,
//                     letterSpacing: 1.0,
//                     height: 1.5,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildStatCard(
//                         "Total Users", "125+", Icons.people_alt_rounded),
//                     _buildStatCard("Matches", "45", Icons.favorite_rounded),
//                     _buildStatCard("Success", "28", Icons.celebration_rounded),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 120,
//                 margin: const EdgeInsets.symmetric(vertical: 20),
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   children: [
//                     _buildFeaturedProfile("Sarah Parker", "28",
//                         "assets/images/female_avatar3.png"),
//                     _buildFeaturedProfile(
//                         "Ronald Dahl", "32", "assets/images/male_avatar.png"),
//                     _buildFeaturedProfile("Emma Wilson", "26",
//                         "assets/images/female_avatar3.png"),
//                     _buildFeaturedProfile(
//                         "Mike Ross", "30", "assets/images/male_avatar.png"),
//                   ],
//                 ),
//               ),
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 padding: const EdgeInsets.all(20),
//                 children: [
//                   _buildDashboardTile(
//                       context, Icons.person_add, "Add User", '/addUser'),
//                   _buildDashboardTile(
//                       context, Icons.list, "User List", '/userList'),
//                   _buildDashboardTile(
//                       context, Icons.favorite, "Favourite", '/favourites'),
//                   _buildDashboardTile(
//                       context, Icons.info, "About Us", '/aboutUs'),
//                 ],
//               ),
//               Container(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.pink.shade100, Colors.red.shade100],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.celebration_rounded,
//                         color: Colors.redAccent, size: 40),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Success Story of the Week",
//                             style: GoogleFonts.poppins(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.red.shade800,
//                             ),
//                           ),
//                           Text(
//                             "John & Sarah found their perfect match!",
//                             style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               color: Colors.grey[800],
//                             ),
//                           ),
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
//   // Widget _buildDashboardTile(
//   //     BuildContext context, IconData icon, String title, String route) {
//   //   return InkWell(
//   //     onTap: () {
//   //       Navigator.pushNamed(context, route);
//   //     },
//   //     borderRadius: BorderRadius.circular(15),
//   //     child: Card(
//   //       elevation: 8,
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//   //       shadowColor: Colors.redAccent.withOpacity(0.5),
//   //       child: Container(
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(15),
//   //           gradient: LinearGradient(
//   //             colors: [Colors.white, Colors.red.shade100],
//   //             begin: Alignment.topLeft,
//   //             end: Alignment.bottomRight,
//   //           ),
//   //         ),
//   //         child: Column(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             Container(
//   //               decoration: BoxDecoration(
//   //                 shape: BoxShape.circle,
//   //                 color: Colors.redAccent.withOpacity(0.1),
//   //               ),
//   //               padding: const EdgeInsets.all(15),
//   //               child: Icon(icon, size: 40, color: Colors.redAccent),
//   //             ),
//   //             const SizedBox(height: 12),
//   //             Text(
//   //               title,
//   //               style: GoogleFonts.poppins(
//   //                 fontSize: 16,
//   //                 fontWeight: FontWeight.w500,
//   //                 color: Colors.black87,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   // Update the _buildDashboardTile method
//   Widget _buildDashboardTile(
//       BuildContext context, IconData icon, String title, String route) {
//     return InkWell(
//       onTap: () => Navigator.pushNamed(context, route),
//       borderRadius: BorderRadius.circular(15),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.red.shade50],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.redAccent.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.redAccent.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Icon(icon, size: 35, color: Colors.redAccent),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.redAccent.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(
//           icon,
//           color: Colors.redAccent,
//           size: 24,
//         ),
//       ),
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: Colors.grey[800],
//         ),
//       ),
//       onTap: onTap,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
// }
//
// Widget _buildStatCard(String title, String count, IconData icon) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           spreadRadius: 2,
//           blurRadius: 5,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     ),
//     child: Column(
//       children: [
//         Icon(icon, color: Colors.redAccent, size: 24),
//         const SizedBox(height: 8),
//         Text(
//           count,
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.redAccent,
//           ),
//         ),
//         Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildFeaturedProfile(String name, String age, String image) {
//   return Container(
//     width: 100,
//     margin: const EdgeInsets.only(right: 15),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(15),
//       gradient: LinearGradient(
//         colors: [Colors.redAccent.withOpacity(0.8), Colors.red.shade800],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundImage: AssetImage(image),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           name,
//           style: GoogleFonts.poppins(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         Text(
//           "$age yrs",
//           style: GoogleFonts.poppins(
//             fontSize: 11,
//             color: Colors.white70,
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = 'Guest';
  String userEmail = 'guest@example.com';
  String userPhotoUrl = "assets/images/image.png";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
      userPhotoUrl = prefs.getString('userPhoto') ?? "assets/images/image.png";
    });
  }

  Future<void> _logout(BuildContext context) async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
              "Are you sure you want to logout?",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent
              )
          ),
          content: Text(
            "You will be logged out of the app.",
            style: GoogleFonts.poppins(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "No",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                "Yes",
                style: GoogleFonts.poppins(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            'True Companion',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            )
        ),
        backgroundColor: Colors.redAccent[400],
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.menu_open_rounded),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        elevation: 8,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: PopupMenuButton<int>(
        //       onSelected: (value) {
        //         if (value == 1) {
        //           _logout(context);
        //         }
        //       },
        //       child: Container(
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
        //         ),
        //         child: CircleAvatar(
        //           radius: 20,
        //           backgroundImage: AssetImage(userPhotoUrl),
        //         ),
        //       ),
        //       itemBuilder: (context) => [
        //         PopupMenuItem<int>(
        //           value: 1,
        //           child: Row(
        //             children: [
        //               const Icon(Icons.logout, color: Colors.redAccent),
        //               const SizedBox(width: 10),
        //               Text("Logout", style: GoogleFonts.poppins()),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 1) {
                  _logout(context);
                }
              },
              offset: const Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(userPhotoUrl),
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  enabled: false,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi $userName,",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        "Glad to see you again!",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Divider(
                        color: Colors.red,
                        thickness:.5,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  height: 50,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.redAccent.withOpacity(0.8), Colors.red.shade600],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          "Logout",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: SizedBox(
        width: 280,
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.red.shade50],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.red.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(userPhotoUrl),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userName,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDrawerItem(
                  icon: Icons.home_rounded,
                  title: "Home",
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.info_rounded,
                  title: "About Us",
                  onTap: () => Navigator.pushNamed(context, '/aboutUs'),
                ),
                _buildDrawerItem(
                  icon: Icons.bar_chart_rounded,
                  title: "Statistics",
                  onTap: () => Navigator.pushNamed(context, '/statistics'),
                ),
                _buildDrawerItem(
                  icon: Icons.help_rounded,
                  title: "FAQs",
                  onTap: () => Navigator.pushNamed(context, '/faq'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout_rounded, color: Colors.white),
                    label: Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.redAccent.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 20.0),
                child: Text(
                  'Welcome to True Companion Matrimony',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    height: 1.5,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.redAccent, Colors.red.shade600],
                      ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Find Your Perfect Match',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                        "Total Users", "125+", Icons.people_alt_rounded),
                    _buildStatCard("Matches", "45", Icons.favorite_rounded),
                    _buildStatCard("Success", "28", Icons.celebration_rounded),
                  ],
                ),
              ),
              // Container(
              //   height: 120,
              //   margin: const EdgeInsets.symmetric(vertical: 20),
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     children: [
              //       _buildFeaturedProfile("Sarah Parker", "28",
              //           "assets/images/female_avatar3.png"),
              //       _buildFeaturedProfile(
              //           "Ronald Dahl", "32", "assets/images/male_avatar.png"),
              //       _buildFeaturedProfile("Emma Wilson", "26",
              //           "assets/images/female_avatar3.png"),
              //       _buildFeaturedProfile(
              //           "Mike Ross", "30", "assets/images/male_avatar.png"),
              //     ],
              //   ),
              // ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.all(20),
                children: [
                  _buildDashboardTile(
                      context, Icons.person_add, "Add User", '/addUser'),
                  _buildDashboardTile(
                      context, Icons.list, "User List", '/userList'),
                  _buildDashboardTile(
                      context, Icons.favorite, "Favourite", '/favourites'),
                  _buildDashboardTile(
                      context, Icons.info, "About Us", '/aboutUs'),
                ],
              ),
              Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade100, Colors.red.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.celebration_rounded,
                        color: Colors.redAccent, size: 40),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Success Story of the Week",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade800,
                            ),
                          ),
                          Text(
                            "John & Sarah found their perfect match!",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[800],
                            ),
                          ),
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
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.redAccent,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildDashboardTile(
      BuildContext context, IconData icon, String title, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.red.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Icon(icon, size: 35, color: Colors.redAccent),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.redAccent, size: 24),
          const SizedBox(height: 8),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProfile(String name, String age, String image) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.redAccent.withOpacity(0.8), Colors.red.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "$age yrs",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}