// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1;
//
//   final List<Widget> _pages = [
//     Center(child: Text("Add User", style: GoogleFonts.poppins(fontSize: 24))),
//     Center(child: Text("User List", style: GoogleFonts.poppins(fontSize: 24))),
//     Center(child: Text("Favourites", style: GoogleFonts.poppins(fontSize: 24))),
//     Center(child: Text("About Us", style: GoogleFonts.poppins(fontSize: 24))),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         backgroundColor: Colors.redAccent,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_add),
//             label: "Add User",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: "User List",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favourites",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info),
//             label: "About Us",
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1;
//
//   final List<Widget> _pages = [
//     Center(child: Text("Add User", style: GoogleFonts.poppins(fontSize: 24))),
//     Center(child: Text("User List", style: GoogleFonts.poppins(fontSize: 24))),
//     Center(child: Text("Favourites", style: GoogleFonts.poppins(fontSize: 24))),
//     Center(child: Text("About Us", style: GoogleFonts.poppins(fontSize: 24))),
//   ];
//
//   final List<IconData> _iconList = [
//     Icons.person_add,
//     Icons.list,
//     Icons.favorite,
//     Icons.info,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: AnimatedBottomNavigationBar(
//         icons: _iconList,
//         activeIndex: _selectedIndex,
//         gapLocation: GapLocation.center,
//         backgroundColor: Colors.redAccent,
//         inactiveColor: Colors.white70,
//         activeColor: Colors.white,
//         notchSmoothness: NotchSmoothness.softEdge,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1;
//
//   final List<String> _routes = [
//     '/addUser',
//     '/userList',
//     '/favourites',
//     '/aboutUs',
//   ];
//
//   final List<IconData> _iconList = [
//     Icons.person_add,
//     Icons.list,
//     Icons.favorite,
//     Icons.info,
//   ];
//
//   final List<String> _titles = [
//     "Add User",
//     "User List",
//     "Favourites",
//     "About Us",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           _titles[_selectedIndex],
//           style: GoogleFonts.poppins(fontSize: 24),
//         ),
//       ),
//       bottomNavigationBar: AnimatedBottomNavigationBar(
//         icons: _iconList,
//         activeIndex: _selectedIndex,
//         gapLocation: GapLocation.center,
//         backgroundColor: Colors.redAccent,
//         inactiveColor: Colors.white70,
//         activeColor: Colors.white,
//         notchSmoothness: NotchSmoothness.softEdge,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           Navigator.pushNamed(context, _routes[index]);
//         },
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1;
//   final NotchBottomBarController _controller = NotchBottomBarController();
//
//   final List<String> _routes = [
//     '/addUser',
//     '/userList',
//     '/favourites',
//     '/aboutUs',
//   ];
//
//   final List<IconData> _iconList = [
//     Icons.person_add,
//     Icons.list,
//     Icons.favorite,
//     Icons.info,
//   ];
//
//   final List<String> _titles = [
//     "Add User",
//     "User List",
//     "Favourites",
//     "About Us",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           _titles[_selectedIndex],
//           style: GoogleFonts.poppins(fontSize: 24),
//         ),
//       ),
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchBottomBarController: _controller,
//         bottomBarItems: List.generate(_iconList.length, (index) => BottomBarItem(
//           inActiveItem: Icon(_iconList[index], color: Colors.white70),
//           activeItem: Icon(_iconList[index], color: Colors.white),
//           itemLabel: _titles[index],
//         )),
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           Navigator.pushNamed(context, _routes[index]);
//         },
//         color: Colors.redAccent,
//         showLabel: true,
//       ),
//     );
//   }
// }

// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1;
//   final NotchBottomBarController _controller = NotchBottomBarController();
//
//   final List<Widget> _pages = [
//     AddUserPage(), // Replace with actual Add User page
//     UserListPage(), // Replace with actual User List page
//     FavoriteUsersPage(), // Replace with actual Favourites page
//     AboutUsScreen(), // Replace with actual About Us page
//   ];
//
//   final List<IconData> _iconList = [
//     Icons.person_add,
//     Icons.list,
//     Icons.favorite,
//     Icons.info,
//   ];
//
//   final List<String> _titles = [
//     "Add User",
//     "User List",
//     "Favourites",
//     "About Us",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchBottomBarController: _controller,
//         bottomBarItems: List.generate(_iconList.length, (index) => BottomBarItem(
//           inActiveItem: Icon(_iconList[index], color: Colors.white70),
//           activeItem: Icon(_iconList[index], color: Colors.white),
//           itemLabel: _titles[index],
//         )),
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         color: Colors.redAccent,
//         showLabel: true, kIconSize: null,
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1;
//   final NotchBottomBarController _controller = NotchBottomBarController();
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<IconData> _iconList = [
//     Icons.person_add,
//     Icons.list,
//     Icons.favorite,
//     Icons.info,
//   ];
//
//   final List<String> _titles = [
//     "Add User",
//     "User List",
//     "Favourites",
//     "About Us",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchBottomBarController: _controller,
//         bottomBarItems: List.generate(
//           _iconList.length,
//               (index) => BottomBarItem(
//             inActiveItem: Icon(_iconList[index], color: Colors.white70),
//             activeItem: Icon(_iconList[index], color: Colors.white),
//             itemLabel: _titles[index],
//           ),
//         ),
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         color: Colors.redAccent,
//         showLabel: true,
//         kIconSize: 30, // Adjust icon size as needed
//         kBottomRadius: 24, // Adjust bottom bar corner radius
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default page is User List
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1); // Sync with default page
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.grey),
//       activeItem: Icon(Icons.person_add, color: Colors.white),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.grey),
//       activeItem: Icon(Icons.list, color: Colors.white),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.grey),
//       activeItem: Icon(Icons.favorite, color: Colors.white),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.grey),
//       activeItem: Icon(Icons.info, color: Colors.white),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchBottomBarController: _controller,
//         bottomBarItems: _bottomBarItems,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         kIconSize: 28, // Proper icon size for good UI
//         kBottomRadius: 22, // Soft rounded corners
//         color: Colors.redAccent,
//         showLabel: true,
//         notchColor: Colors.white,
//         bottomBarWidth: MediaQuery.of(context).size.width * 0.94, // Adjusted width for modern look
//         elevation: 10, // Adds a shadow for a lifted effect
//         durationInMilliSeconds: 300, // Smooth transition animation
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default to User List page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1);
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: Icon(Icons.person_add, color: Colors.redAccent),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: Icon(Icons.list, color: Colors.redAccent),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: Icon(Icons.favorite, color: Colors.redAccent),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: Icon(Icons.info, color: Colors.redAccent),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade400, Colors.redAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           kIconSize: 30,
//           kBottomRadius: 22,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.redAccent,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 8,
//           durationInMilliSeconds: 300,
//         ),
//       ),
//     );
//   }
// }

// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default to User List page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1);
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.person_add),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.list),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.favorite),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.info),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   static Widget _buildActiveIcon(IconData icon) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white.withOpacity(0.3),
//       ),
//       padding: EdgeInsets.all(10),
//       child: Icon(icon, color: Colors.white, size: 30),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade500, Colors.redAccent.shade700],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           kIconSize: 30,
//           kBottomRadius: 22,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.white,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 10,
//           durationInMilliSeconds: 300,
//         ),
//       ),
//     );
//   }
// }

// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default to User List page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1);
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.person_add),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.list),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.favorite),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.info),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   static Widget _buildActiveIcon(IconData icon) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white.withOpacity(0.7),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.redAccent.shade200,
//             blurRadius: 5.0,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: EdgeInsets.all(10),
//       child: Icon(icon, color: Colors.white, size: 30),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade500, Colors.redAccent.shade700],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           kIconSize: 30,
//           kBottomRadius: 30,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.white,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 10,
//           durationInMilliSeconds: 300,
//           itemLabelStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default to User List page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1);
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.person_add),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.list),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.favorite),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.info),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   static Widget _buildActiveIcon(IconData icon) {
//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(8), // Add padding around the icon
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.pinkAccent.withOpacity(0.9), // Slightly opaque for better contrast
//           boxShadow: [
//             BoxShadow(
//               color: Colors.redAccent.shade200,
//               blurRadius: 15.0,
//               offset: Offset(0, 4), // Adjust shadow direction
//             ),
//             BoxShadow(
//               color: Colors.redAccent.shade100,
//               blurRadius: 10.0,
//               offset: Offset(0, -2), // Secondary subtle shadow
//             ),
//           ],
//         ),
//         child: AnimatedScale(
//           scale: 1.2, // Slight scale animation for active state
//           duration: Duration(milliseconds: 200),
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 30,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade500, Colors.redAccent.shade700],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.pinkAccent,
//               blurRadius: 10,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           kIconSize: 30,
//           kBottomRadius: 30,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.white,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 10,
//           durationInMilliSeconds: 300,
//           itemLabelStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default to User List page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1);
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.person_add),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.list),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.favorite),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.info),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   static Widget _buildActiveIcon(IconData icon) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [Colors.white.withOpacity(0.9), Colors.redAccent.shade200],
//               center: Alignment(0.0, 0.0),
//               radius: 0.6,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.redAccent.shade100.withOpacity(0.7),
//                 blurRadius: 10,
//                 spreadRadius: 3,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//         ),
//         Icon(
//           icon,
//           color: Colors.red.shade900,
//           size: 28,
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade700, Colors.redAccent.shade400],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.shade900,
//               blurRadius: 12,
//               spreadRadius: 3,
//               offset: Offset(0, -3),
//             ),
//           ],
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           kIconSize: 30,
//           kBottomRadius: 30,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.white,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 10,
//           durationInMilliSeconds: 300,
//           itemLabelStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 1; // Default to User List page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 1);
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.person_add),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.list),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.favorite),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.info),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   static Widget _buildActiveIcon(IconData icon) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [Colors.white.withOpacity(0.9), Colors.redAccent.shade200],
//               center: Alignment(0.0, 0.0),
//               radius: 0.6,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.redAccent.shade100.withOpacity(0.7),
//                 blurRadius: 10,
//                 spreadRadius: 3,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//         ),
//         Icon(
//           icon,
//           color: Colors.red.shade900,
//           size: 28,
//         ),
//       ],
//     );
//   }
//
//   void _onTabSelected(int index) {
//     if (_selectedIndex == index) return; // Prevent unnecessary rebuilds
//
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   Route _createPageRoute(Widget page) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0); // Slide in from right
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;
//
//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         var fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: FadeTransition(
//             opacity: animation.drive(fadeTween),
//             child: child,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedSwitcher(
//         duration: Duration(milliseconds: 300),
//         transitionBuilder: (child, animation) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//         child: _pages[_selectedIndex],
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade700, Colors.redAccent.shade400],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.shade900.withOpacity(0.6),
//               blurRadius: 12,
//               spreadRadius: 3,
//               offset: Offset(0, -3),
//             ),
//           ],
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             if (_selectedIndex != index) {
//               Navigator.of(context).push(_createPageRoute(_pages[index]));
//             }
//             _onTabSelected(index);
//           },
//           kIconSize: 30,
//           kBottomRadius: 30,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.white,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 10,
//           durationInMilliSeconds: 300,
//           itemLabelStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
//
// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }
//
// class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
//   int _selectedIndex = 1; // Default page: User List
//   final _controller = NotchBottomBarController(index: 1);
//
//   late PageController _pageController;
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: Icon(Icons.person_add, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.person_add),
//       itemLabel: "Add User",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.list, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.list),
//       itemLabel: "User List",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.favorite_border, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.favorite),
//       itemLabel: "Favourites",
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(Icons.info_outline, color: Colors.white70),
//       activeItem: _buildActiveIcon(Icons.info),
//       itemLabel: "About Us",
//     ),
//   ];
//
//   static Widget _buildActiveIcon(IconData icon) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [Colors.white.withOpacity(0.9), Colors.redAccent.shade200],
//               center: Alignment(0.0, 0.0),
//               radius: 0.6,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.redAccent.shade100.withOpacity(0.7),
//                 blurRadius: 10,
//                 spreadRadius: 3,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//         ),
//         Icon(
//           icon,
//           color: Colors.red.shade900,
//           size: 28,
//         ),
//       ],
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _selectedIndex);
//   }
//
//   void _onTabSelected(int index) {
//     if (_selectedIndex == index) return; // Prevent unnecessary reloads
//
//     setState(() {
//       _selectedIndex = index;
//       _pageController.animateToPage(
//         index,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: NeverScrollableScrollPhysics(), // Prevent swipe to change pages manually
//         children: _pages,
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.redAccent.shade200, Colors.pinkAccent.shade200],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.shade900.withOpacity(0.6),
//               blurRadius: 12,
//               spreadRadius: 3,
//               offset: Offset(0, -3),
//             ),
//           ],
//         ),
//         child: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           bottomBarItems: _bottomBarItems,
//           onTap: (index) {
//             _onTabSelected(index);
//           },
//           kIconSize: 30,
//           kBottomRadius: 30,
//           color: Colors.transparent,
//           showLabel: true,
//           notchColor: Colors.white,
//           bottomBarWidth: MediaQuery.of(context).size.width * 0.94,
//           elevation: 10,
//           durationInMilliSeconds: 300,
//           itemLabelStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


//new navBar


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:matrimony_app/ui/about_us.dart';
// import 'package:matrimony_app/ui/add_user.dart';
// import 'package:matrimony_app/ui/favourite_user.dart';
// import 'package:matrimony_app/ui/user_list.dart';
//
// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }
//
// class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _pages.length, vsync: this, initialIndex: 1);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SoulMate Connect", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.redAccent,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           indicatorWeight: 3,
//           labelStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
//           tabs: [
//             Tab(icon: Icon(Icons.person_add), text: "Add User"),
//             Tab(icon: Icon(Icons.list), text: "Users"),
//             Tab(icon: Icon(Icons.favorite), text: "Favourites"),
//             Tab(icon: Icon(Icons.info), text: "About"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: _pages,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:matrimony_app/ui/about_us.dart';
// // import 'package:matrimony_app/ui/add_user.dart';
// // import 'package:matrimony_app/ui/favourite_user.dart';
// // import 'package:matrimony_app/ui/user_list.dart';
//
// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }
//
// class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentIndex = 1; // Default to User List
//
//   final List<Widget> _pages = [
//     AddUserPage(),
//     UserListPage(),
//     FavoriteUsersPage(),
//     AboutUsScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _pages.length, vsync: this, initialIndex: _currentIndex);
//   }
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//       _tabController.animateTo(index); // Animate tab switch
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: _tabController,
//         physics: BouncingScrollPhysics(), // Adds smooth scrolling effect
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         backgroundColor: Colors.redAccent,
//         type: BottomNavigationBarType.fixed,
//         elevation: 10,
//         onTap: _onTabTapped,
//         selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: GoogleFonts.poppins(),
//         items: [
//           _buildAnimatedNavItem(Icons.person_add, "Add User", 0),
//           _buildAnimatedNavItem(Icons.list, "Users", 1),
//           _buildAnimatedNavItem(Icons.favorite, "Favourites", 2),
//           _buildAnimatedNavItem(Icons.info, "About", 3),
//         ],
//       ),
//     );
//   }
//
//   /// Animated Bottom Navigation Bar Item
//   BottomNavigationBarItem _buildAnimatedNavItem(IconData icon, String label, int index) {
//     return BottomNavigationBarItem(
//       icon: AnimatedSwitcher(
//         duration: Duration(milliseconds: 300),
//         transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
//         child: Icon(
//           icon,
//           key: ValueKey<int>(_currentIndex == index ? 1 : 0),
//           size: _currentIndex == index ? 30 : 25, // Slightly larger icon when selected
//         ),
//       ),
//       label: label,
//     );
//   }
// }
