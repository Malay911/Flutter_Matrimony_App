// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login_screen.dart';
//
// class DashboardScreen extends StatelessWidget {
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('True Companion',
//             style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
//         backgroundColor: Colors.redAccent[400],
//         centerTitle: true,
//         elevation: 5,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout, color: Colors.white),
//             onPressed: () => _logout(context),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.redAccent.shade400],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//               child: Text(
//                 'Welcome to True Companion Matrimony',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                   letterSpacing: 1.2,
//                   height: 1.5,
//                   shadows: [
//                     Shadow(
//                       offset: Offset(2, 2),
//                       blurRadius: 3,
//                       color: Colors.grey.withOpacity(0.5),
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 'Find Your Forever',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey.shade600,
//                   letterSpacing: 1.0,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 padding: EdgeInsets.all(20),
//                 children: [
//                   _buildDashboardTile(context, Icons.person_add, "Add User", '/addUser'),
//                   _buildDashboardTile(context, Icons.list, "User List", '/userList'),
//                   _buildDashboardTile(context, Icons.favorite, "Favourite", '/favourites'),
//                   _buildDashboardTile(context, Icons.info, "About Us", '/aboutUs'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardTile(BuildContext context, IconData icon, String title, String route) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, route);
//       },
//       borderRadius: BorderRadius.circular(15),
//       child: Card(
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         shadowColor: Colors.redAccent.withOpacity(0.5),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.red.shade100],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.redAccent.withOpacity(0.1),
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Icon(icon, size: 40, color: Colors.redAccent),
//               ),
//               SizedBox(height: 12),
//               Text(
//                 title,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login_screen.dart';
//
// class DashboardScreen extends StatelessWidget {
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('True Companion',
//             style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
//         backgroundColor: Colors.redAccent[400],
//         centerTitle: true,
//         elevation: 5,
//         actions: [
//         // IconButton(
//         //     icon: Icon(Icons.logout, color: Colors.white),
//         //     onPressed: () => _logout(context),
//         //   ),
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: PopupMenuButton<int>(
//               onSelected: (value) {
//                 if (value == 1) {
//                   _logout(context);
//                 }
//               },
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: user?.photoURL != null
//                         ? NetworkImage(user!.photoURL!)
//                         : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//                   ),
//                   // SizedBox(width: 10),
//                   // Text(
//                   //   user?.displayName ?? "User",
//                   //   style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
//                   // ),
//                 ],
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem<int>(
//                   value: 1,
//                   child: Row(
//                     children: [
//                       Icon(Icons.logout, color: Colors.redAccent),
//                       SizedBox(width: 10),
//                       Text("Logout", style: GoogleFonts.poppins()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text(
//                 user?.displayName ?? 'Guest',
//                 style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               accountEmail: Text(
//                 user?.email ?? 'guest@example.com',
//                 style: GoogleFonts.poppins(fontSize: 14),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: user?.photoURL != null
//                     ? NetworkImage(user!.photoURL!)
//                     : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.redAccent[400]
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home, color: Colors.redAccent),
//               title: Text("Home", style: GoogleFonts.poppins()),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: Icon(Icons.favorite, color: Colors.redAccent),
//               title: Text("Favourites", style: GoogleFonts.poppins()),
//               onTap: () => Navigator.pushNamed(context, '/favourites'),
//             ),
//             ListTile(
//               leading: Icon(Icons.info, color: Colors.redAccent),
//               title: Text("About Us", style: GoogleFonts.poppins()),
//               onTap: () => Navigator.pushNamed(context, '/aboutUs'),
//             ),
//             Spacer(),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.logout, color: Colors.redAccent),
//               title: Text("Logout", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
//               onTap: () => _logout(context),
//             ),
//           ],
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
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//               child: Text(
//                 'Welcome to True Companion Matrimony',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                   letterSpacing: 1.2,
//                   height: 1.5,
//                   shadows: [
//                     Shadow(
//                       offset: Offset(2, 2),
//                       blurRadius: 3,
//                       color: Colors.grey.withOpacity(0.5),
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 'Find Your Forever',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey.shade600,
//                   letterSpacing: 1.0,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 padding: EdgeInsets.all(20),
//                 children: [
//                   _buildDashboardTile(context, Icons.person_add, "Add User", '/addUser'),
//                   _buildDashboardTile(context, Icons.list, "User List", '/userList'),
//                   _buildDashboardTile(context, Icons.favorite, "Favourite", '/favourites'),
//                   _buildDashboardTile(context, Icons.info, "About Us", '/aboutUs'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardTile(BuildContext context, IconData icon, String title, String route) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, route);
//       },
//       borderRadius: BorderRadius.circular(15),
//       child: Card(
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         shadowColor: Colors.redAccent.withOpacity(0.5),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.red.shade100],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.redAccent.withOpacity(0.1),
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Icon(icon, size: 40, color: Colors.redAccent),
//               ),
//               SizedBox(height: 12),
//               Text(
//                 title,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login_screen.dart';
//
// class DashboardScreen extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('True Companion',
//             style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
//         backgroundColor: Colors.redAccent[400],
//         leading: IconButton(
//           color: Colors.white,
//           icon: Icon(Icons.menu_open_rounded),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         centerTitle: true,
//         elevation: 5,
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: PopupMenuButton<int>(
//               onSelected: (value) {
//                 if (value == 1) {
//                   _logout(context);
//                 }
//               },
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: user?.photoURL != null
//                         ? NetworkImage(user!.photoURL!)
//                         : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//                   ),
//                 ],
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem<int>(
//                   value: 1,
//                   child: Row(
//                     children: [
//                       Icon(Icons.logout, color: Colors.redAccent),
//                       SizedBox(width: 10),
//                       Text("Logout", style: GoogleFonts.poppins()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // drawer: Drawer(
//       //   child: Column(
//       //     children: [
//       //       UserAccountsDrawerHeader(
//       //         accountName: Text(
//       //           user?.displayName ?? 'Guest',
//       //           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
//       //         ),
//       //         accountEmail: Text(
//       //           user?.email ?? 'guest@example.com',
//       //           style: GoogleFonts.poppins(fontSize: 14),
//       //         ),
//       //         currentAccountPicture: CircleAvatar(
//       //           backgroundImage: user?.photoURL != null
//       //               ? NetworkImage(user!.photoURL!)
//       //               : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//       //         ),
//       //         decoration: BoxDecoration(
//       //             color: Colors.redAccent[400]
//       //         ),
//       //       ),
//       //       ListTile(
//       //         leading: Icon(Icons.home, color: Colors.redAccent),
//       //         title: Text("Home", style: GoogleFonts.poppins()),
//       //         onTap: () => Navigator.pop(context),
//       //       ),
//       //       ListTile(
//       //         leading: Icon(Icons.favorite, color: Colors.redAccent),
//       //         title: Text("Favourites", style: GoogleFonts.poppins()),
//       //         onTap: () => Navigator.pushNamed(context, '/favourites'),
//       //       ),
//       //       ListTile(
//       //         leading: Icon(Icons.info, color: Colors.redAccent),
//       //         title: Text("About Us", style: GoogleFonts.poppins()),
//       //         onTap: () => Navigator.pushNamed(context, '/aboutUs'),
//       //       ),
//       //       Spacer(),
//       //       Divider(),
//       //       ListTile(
//       //         leading: Icon(Icons.logout, color: Colors.redAccent),
//       //         title: Text("Logout", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
//       //         onTap: () => _logout(context),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       drawer: Container(
//         width: 260,
//         child: Drawer(
//           child: Container(
//             color: Colors.redAccent[50],
//             child: Column(
//               children: [
//                 // Drawer Header
//                 // UserAccountsDrawerHeader(
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.redAccent[400], // Gradient or solid color for header
//                 //     borderRadius: BorderRadius.only(
//                 //       bottomLeft: Radius.circular(30.0),
//                 //       bottomRight: Radius.circular(30.0),
//                 //     ),
//                 //   ),
//                 //   accountName: Text(
//                 //     user?.displayName ?? 'Guest',
//                 //     style: GoogleFonts.poppins(
//                 //       fontSize: 18,
//                 //       fontWeight: FontWeight.w600,
//                 //       color: Colors.white,
//                 //     ),
//                 //   ),
//                 //   accountEmail: Text(
//                 //     user?.email ?? 'guest@example.com',
//                 //     style: GoogleFonts.poppins(
//                 //       fontSize: 14,
//                 //       color: Colors.white70,
//                 //     ),
//                 //   ),
//                 //   currentAccountPicture: CircleAvatar(
//                 //     backgroundImage: user?.photoURL != null
//                 //         ? NetworkImage(user!.photoURL!)
//                 //         : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//                 //     radius: 40,
//                 //   ),
//                 // ),
//                 UserAccountsDrawerHeader(
//                   decoration: BoxDecoration(
//                     color: Colors.redAccent, // Gradient or solid color for header
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(30.0),
//                       bottomRight: Radius.circular(30.0),
//                     ),
//                   ),
//                   accountName: Text(
//                     user?.displayName ?? 'Guest',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center, // Centering the name horizontally
//                   ),
//                   accountEmail: Text(
//                     user?.email ?? 'guest@example.com',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                     textAlign: TextAlign.center, // Centering the email horizontally
//                   ),
//                   currentAccountPicture: CircleAvatar(
//                     backgroundImage: user?.photoURL != null
//                         ? NetworkImage(user!.photoURL!)
//                         : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//                     radius: 40,
//                   ),
//                 ),
//                 // List Tile 1 (Home)
//                 _buildDrawerItem(
//                   icon: Icons.home,
//                   title: "Home",
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 //List Tile 2
//                 _buildDrawerItem(
//                   icon: Icons.list_rounded,
//                   title: "User List",
//                   onTap: () => Navigator.pushNamed(context, '/userList'),
//                 ),
//                 // List Tile 3 (Favourites)
//                 _buildDrawerItem(
//                   icon: Icons.favorite,
//                   title: "Favourites",
//                   onTap: () => Navigator.pushNamed(context, '/favourites'),
//                 ),
//                 // List Tile 4 (About Us)
//                 _buildDrawerItem(
//                   icon: Icons.info,
//                   title: "About Us",
//                   onTap: () => Navigator.pushNamed(context, '/aboutUs'),
//                 ),
//                 Spacer(),
//                 Divider(
//                   color: Colors.grey[300], // Light divider for separation
//                 ),
//                 // Logout Tile
//                 _buildDrawerItem(
//                   icon: Icons.logout,
//                   title: "Logout",
//                   onTap: () => _logout(context),
//                   iconColor: Colors.redAccent,
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
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//               child: Text(
//                 'Welcome to True Companion Matrimony',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                   letterSpacing: 1.2,
//                   height: 1.5,
//                   shadows: [
//                     Shadow(
//                       offset: Offset(2, 2),
//                       blurRadius: 3,
//                       color: Colors.grey.withOpacity(0.5),
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 'Find Your Forever',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey.shade600,
//                   letterSpacing: 1.0,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 padding: EdgeInsets.all(20),
//                 children: [
//                   _buildDashboardTile(context, Icons.person_add, "Add User", '/addUser'),
//                   _buildDashboardTile(context, Icons.list, "User List", '/userList'),
//                   _buildDashboardTile(context, Icons.favorite, "Favourite", '/favourites'),
//                   _buildDashboardTile(context, Icons.info, "About Us", '/aboutUs'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardTile(BuildContext context, IconData icon, String title, String route) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, route);
//       },
//       borderRadius: BorderRadius.circular(15),
//       child: Card(
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         shadowColor: Colors.redAccent.withOpacity(0.5),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.red.shade100],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.redAccent.withOpacity(0.1),
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Icon(icon, size: 40, color: Colors.redAccent),
//               ),
//               SizedBox(height: 12),
//               Text(
//                 title,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color? iconColor = Colors.redAccent,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//       leading: Icon(icon, color: iconColor, size: 30), // Custom icon size
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _logout(BuildContext context) async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure you want to logout?"),
          content: Text("You will be logged out of the app."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {

    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('True Companion',
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
        backgroundColor: Colors.redAccent[400],
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.menu_open_rounded),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        elevation: 5,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 1) {
                  _logout(context);
                }
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : AssetImage("assets/images/default_avatar.png") as ImageProvider,
                  ),
                ],
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.redAccent),
                      SizedBox(width: 10),
                      Text("Logout", style: GoogleFonts.poppins()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Container(
        width: 260,
        child: Drawer(
          child: Container(
            color: Colors.redAccent[50],
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  accountName: Text(
                    user?.displayName ?? 'Guest',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center, // Centering the name horizontally
                  ),
                  accountEmail: Text(
                    user?.email ?? 'guest@example.com',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center, // Centering the email horizontally
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : AssetImage("assets/images/default_avatar.png") as ImageProvider,
                    radius: 40,
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.home,
                  title: "Home",
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.list_rounded,
                  title: "User List",
                  onTap: () => Navigator.pushNamed(context, '/userList'),
                ),
                _buildDrawerItem(
                  icon: Icons.favorite,
                  title: "Favourites",
                  onTap: () => Navigator.pushNamed(context, '/favourites'),
                ),
                _buildDrawerItem(
                  icon: Icons.info,
                  title: "About Us",
                  onTap: () => Navigator.pushNamed(context, '/aboutUs'),
                ),
                Spacer(),
                Divider(
                  color: Colors.grey[300],
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () => _logout(context),
                  iconColor: Colors.redAccent,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                'Welcome to True Companion Matrimony',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                  height: 1.5,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Find Your Forever',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  letterSpacing: 1.0,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: EdgeInsets.all(20),
                children: [
                  _buildDashboardTile(context, Icons.person_add, "Add User", '/addUser'),
                  _buildDashboardTile(context, Icons.list, "User List", '/userList'),
                  _buildDashboardTile(context, Icons.favorite, "Favourite", '/favourites'),
                  _buildDashboardTile(context, Icons.info, "About Us", '/aboutUs'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile(BuildContext context, IconData icon, String title, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.redAccent.withOpacity(0.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.red.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withOpacity(0.1),
                ),
                padding: EdgeInsets.all(15),
                child: Icon(icon, size: 40, color: Colors.redAccent),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
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
    Color? iconColor = Colors.redAccent,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      leading: Icon(icon, color: iconColor, size: 30), // Custom icon size
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}

// class DashboardScreen extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<void> _logout(BuildContext context) async {
//     // Logout logic remains the same
//     bool? shouldLogout = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Are you sure you want to logout?"),
//           content: Text("You will be logged out of the app."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: Text("No"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 await prefs.setBool('isLoggedIn', false);
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//               child: Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(
//           'True Companion',
//           style: GoogleFonts.poppins(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.red.shade400,
//         leading: IconButton(
//           icon: Icon(Icons.menu_rounded, color: Colors.white),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: PopupMenuButton<int>(
//               onSelected: (value) {
//                 if (value == 1) _logout(context);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 2,
//                   ),
//                 ),
//                 child: CircleAvatar(
//                   radius: 18,
//                   backgroundImage: user?.photoURL != null
//                       ? NetworkImage(user!.photoURL!)
//                       : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//                 ),
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem<int>(
//                   value: 1,
//                   child: Row(
//                     children: [
//                       Icon(Icons.logout, color: Colors.red.shade400),
//                       SizedBox(width: 10),
//                       Text("Logout", style: GoogleFonts.poppins()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       drawer: Container(
//         width: 280,
//         child: Drawer(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.red.shade50,
//                   Colors.white,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.red.shade400, Colors.red.shade600],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.white,
//                         child: CircleAvatar(
//                           radius: 47,
//                           backgroundImage: user?.photoURL != null
//                               ? NetworkImage(user!.photoURL!)
//                               : AssetImage("assets/images/default_avatar.png") as ImageProvider,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Text(
//                         user?.displayName ?? 'Guest',
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         user?.email ?? 'guest@example.com',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 _buildDrawerItem(
//                   icon: Icons.home_rounded,
//                   title: "Home",
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.people_rounded,
//                   title: "User List",
//                   onTap: () => Navigator.pushNamed(context, '/userList'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.favorite_rounded,
//                   title: "Favourites",
//                   onTap: () => Navigator.pushNamed(context, '/favourites'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.info_rounded,
//                   title: "About Us",
//                   onTap: () => Navigator.pushNamed(context, '/aboutUs'),
//                 ),
//                 Spacer(),
//                 Divider(color: Colors.red.shade100),
//                 _buildDrawerItem(
//                   icon: Icons.logout_rounded,
//                   title: "Logout",
//                   onTap: () => _logout(context),
//                   iconColor: Colors.red.shade400,
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.red.shade50,
//               Colors.red.shade100,
//               Colors.white,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(24.0),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.red.shade400, Colors.red.shade300],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome to',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         color: Colors.white70,
//                       ),
//                     ),
//                     Text(
//                       'True Companion Matrimony',
//                       style: GoogleFonts.poppins(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Find Your Forever',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: GridView.count(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 20,
//                   children: [
//                     _buildDashboardTile(context, Icons.person_add_rounded, "Add User", '/addUser'),
//                     _buildDashboardTile(context, Icons.people_rounded, "User List", '/userList'),
//                     _buildDashboardTile(context, Icons.favorite_rounded, "Favourite", '/favourites'),
//                     _buildDashboardTile(context, Icons.info_rounded, "About Us", '/aboutUs'),
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
//   Widget _buildDashboardTile(BuildContext context, IconData icon, String title, String route) {
//     return InkWell(
//       onTap: () => Navigator.pushNamed(context, route),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.shade100,
//               blurRadius: 10,
//               offset: Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.red.shade50, Colors.red.shade100],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 icon,
//                 size: 32,
//                 color: Colors.red.shade400,
//               ),
//             ),
//             SizedBox(height: 12),
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.red.shade700,
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
//     Color? iconColor,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//       leading: Icon(
//         icon,
//         color: iconColor ?? Colors.red.shade300,
//         size: 24,
//       ),
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: Colors.red.shade700,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }