//region 1

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'add_user.dart';
// import 'edit_user.dart';
// import 'login_screen.dart';
// import 'user_class.dart';
// import 'user_details.dart';
// import 'user_data.dart';
// import 'database_helper.dart';
//
// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }
//
// class _UserListPageState extends State<UserListPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController searchController = TextEditingController();
//   List<User> filteredUsers = [];
//   List<User> userList = [];
//   String userName = 'Guest';
//   String userEmail = 'guest@example.com';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userName = prefs.getString('userName') ?? 'Guest';
//       userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
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
//   void _loadUsers() async {
//     try {
//       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//       List<User> users = await databaseHelper.fetchUsers();
//       if (mounted) {
//         setState(() {
//           users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//           userList = users;
//           filteredUsers = List.from(userList);
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading users: ${e.toString()}')),
//         );
//       }
//     }
//   }
//
//   void _filterUsers(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredUsers = List.from(userList);
//       } else {
//         filteredUsers = userList.where((user) {
//           String name = user.name?.toLowerCase() ?? '';
//           String city = user.city?.toLowerCase() ?? '';
//           String email = user.email?.toLowerCase() ?? '';
//           String phone = user.phone?.toLowerCase() ?? '';
//           String age = user.age?.toString() ?? '';
//
//           query = query.toLowerCase();
//
//           return name.contains(query) ||
//               city.contains(query) ||
//               email.contains(query) ||
//               phone.contains(query) ||
//               age.contains(query);
//         }).toList();
//       }
//     });
//   }
//
//   void _editUser(User user) async {
//     final updatedUser = await Navigator.push<User>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditUserPage(user: user),
//       ),
//     );
//
//     if (updatedUser != null) {
//       try {
//         // Update in database
//         await DatabaseHelper.instance.updateUser(updatedUser);
//
//         // Update in local lists
//         setState(() {
//           int index = userList.indexWhere((u) => u.id == updatedUser.id);
//           if (index != -1) {
//             userList[index] = updatedUser;
//             // Update filtered list as well
//             filteredUsers = List.from(userList);
//           }
//         });
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating user: $e')),
//         );
//       }
//     }
//   }
//
//   void _toggleFavorite(User user) async {
//     if (user.isFavorite) {
//       bool? confirmUnfavorite = await showDialog<bool>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Confirm Unfavorite',
//                 style: GoogleFonts.poppins(fontSize: 16)),
//             content: Text('Are you sure you want to unfavorite this user?',
//                 style: GoogleFonts.poppins(fontSize: 14)),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false); // User chose to cancel
//                 },
//                 child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true); // User confirmed unfavorite
//                 },
//                 child: Text('Unfavorite',
//                     style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//             ],
//           );
//         },
//       );
//
//       if (confirmUnfavorite == true) {
//         DatabaseHelper databaseHelper = DatabaseHelper.instance;
//         bool newFavoriteStatus = !user.isFavorite;
//         setState(() {
//           user.isFavorite = newFavoriteStatus;
//         });
//         await databaseHelper.updateUser(user);
//       }
//     } else {
//       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//       bool newFavoriteStatus = !user.isFavorite;
//       setState(() {
//         user.isFavorite = newFavoriteStatus;
//       });
//       await databaseHelper.updateUser(user);
//     }
//   }
//
//   void _confirmDelete(User user) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion',
//               style: GoogleFonts.poppins(fontSize: 16)),
//           content: Text('Are you sure you want to delete this user?',
//               style: GoogleFonts.poppins(fontSize: 14)),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//             ),
//             TextButton(
//               onPressed: () async {
//                 DatabaseHelper databaseHelper = DatabaseHelper.instance;
//                 await databaseHelper
//                     .deleteUser(user.id!); // Delete using user ID
//
//                 // Remove from both lists (userList and filteredUsers)
//                 setState(() {
//                   userList.remove(user);
//                   filteredUsers =
//                       List.from(userList); // Update the UI after deleting
//                 });
//
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete', style: GoogleFonts.poppins(fontSize: 14)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _applyFilterSort(String sortBy, String order) {
//     setState(() {
//       filteredUsers.sort((a, b) {
//         int comparison = 0;
//
//         // Compare based on selected sorting field
//         switch (sortBy) {
//           case 'name':
//             comparison = a.name!.compareTo(b.name!);
//             break;
//           case 'age':
//             comparison = a.age!.compareTo(b.age!);
//             break;
//           case 'gender':
//             comparison = a.gender!.compareTo(b.gender!);
//             break;
//         }
//
//         // Apply ascending or descending order
//         return order == 'asc' ? comparison : -comparison;
//       });
//     });
//   }
//
//   String selectedSortBy = 'name';
//   String selectedOrder = 'asc';
//
//   void _openFilterDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               title: Text(
//                 'Filter & Sort Users',
//                 style: GoogleFonts.poppins(
//                     fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Sorting by column with icons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Sort by:',
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, fontWeight: FontWeight.w600),
//                       ),
//                       DropdownButton<String>(
//                         value: selectedSortBy,
//                         items: [
//                           DropdownMenuItem(
//                             value: 'name',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.person,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Name',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'age',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.cake_rounded,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Age',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'gender',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.people_alt_rounded,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Gender',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             selectedSortBy = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Sorting order with icons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Order:',
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, fontWeight: FontWeight.w600),
//                       ),
//                       DropdownButton<String>(
//                         value: selectedOrder,
//                         items: [
//                           DropdownMenuItem(
//                             value: 'asc',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.arrow_upward,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Ascending',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'desc',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.arrow_downward,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Descending',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             selectedOrder = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.red, // Color of the button text
//                   ),
//                   child:
//                       Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Apply filter and sorting
//                     _applyFilterSort(selectedSortBy, selectedOrder);
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent[400],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                   child: Text('Apply',
//                       style: GoogleFonts.poppins(
//                           fontSize: 14, color: Colors.white)),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _navigateToDetails(User user) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UserDetailsPage(
//           user: user,
//           onUpdate: (updatedUser) {
//             _loadUsers();
//           },
//           onDelete: (userToDelete) {
//             _confirmDelete(userToDelete);
//           },
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
//         child: Icon(icon, color: Colors.redAccent, size: 24),
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
//
//   Widget _buildUserCard(User user) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () => _navigateToDetails(user),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(3),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Colors.redAccent,
//                                 width: 2,
//                               ),
//                             ),
//                             child: CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.grey[200],
//                               child: ClipOval(
//                                 child: Image.asset(
//                                   user.gender?.toLowerCase() == 'male'
//                                       ? 'assets/images/male_avatar.png'
//                                       : 'assets/images/female_avatar3.png',
//                                   fit: BoxFit.cover,
//                                   height: 60,
//                                   width: 60,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Icon(Icons.person, size: 40);
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   user.name!,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 Text(
//                                   "${user.occupation}",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               user.isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: user.isFavorite
//                                   ? Colors.red
//                                   : Colors.grey[400],
//                               size: 28,
//                             ),
//                             onPressed: () => _toggleFavorite(user),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       _buildInfoRow(Icons.cake_rounded,
//                           "${user.age ?? 'N/A'} years", Colors.purple),
//                       SizedBox(height: 8),
//                       _buildInfoRow(Icons.location_on_rounded,
//                           user.city ?? 'N/A', Colors.blue),
//                       SizedBox(height: 8),
//                       _buildInfoRow(Icons.email_rounded, user.email ?? 'N/A',
//                           Colors.orange),
//                       SizedBox(height: 8),
//                       _buildInfoRow(Icons.phone_rounded, user.phone ?? 'N/A',
//                           Colors.green),
//                     ],
//                   ),
//                 ),
//                 Divider(height: 1),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildActionButton(
//                         icon: Icons.edit_rounded,
//                         label: 'Edit',
//                         color: Colors.blue,
//                         onTap: () => _editUser(user),
//                       ),
//                       Container(
//                         width: 1,
//                         height: 24,
//                         color: Colors.grey[300],
//                       ),
//                       _buildActionButton(
//                         icon: Icons.delete_rounded,
//                         label: 'Delete',
//                         color: Colors.red,
//                         onTap: () => _confirmDelete(user),
//                       ),
//                     ],
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
//   Widget _buildInfoRow(IconData icon, String text, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: color),
//         SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             text,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           children: [
//             Icon(icon, size: 20, color: color),
//             SizedBox(width: 8),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 color: color,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text(
//           'User List',
//           style: GoogleFonts.poppins(
//               fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent[400],
//         elevation: 5,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(Icons.menu_open_rounded, color: Colors.white),
//           ),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list, color: Colors.white),
//             onPressed: _openFilterDialog,
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
//                           backgroundImage:
//                           AssetImage("assets/images/image.png"),
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
//                 _buildDrawerItem(
//                   icon: Icons.home_rounded,
//                   title: "Home",
//                   onTap: () => Navigator.pushNamed(context, '/dashboard'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.person_add_alt_1_rounded,
//                   title: "Create Profiles",
//                   onTap: () => Navigator.pushNamed(context, '/addUser'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.favorite_rounded,
//                   title: "Favourites Profiles",
//                   onTap: () => Navigator.pushNamed(context, '/favourites'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.info_rounded,
//                   title: "About Us",
//                   onTap: () => Navigator.pushNamed(context, '/aboutUs'),
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
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.redAccent.shade400,
//               Colors.red.shade50,
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: MediaQuery.of(context).padding.top + 56 + 16),
//             // Search Bar
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: _filterUsers,
//                   decoration: InputDecoration(
//                     hintText: 'Search profiles...',
//                     hintStyle: GoogleFonts.poppins(color: Colors.grey),
//                     prefixIcon:
//                         Icon(Icons.search_rounded, color: Colors.redAccent),
//                     border: InputBorder.none,
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             // User List
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.only(bottom: 100),
//                 itemCount: filteredUsers.length,
//                 itemBuilder: (context, index) =>
//                     _buildUserCard(filteredUsers[index]),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Wait for the result from AddUserPage
//           User? newUser = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddUserPage(),
//             ),
//           );
//
//           if (newUser != null) {
//             setState(() {
//               userList.insert(0, newUser);
//               filteredUsers = List.from(userList);
//             });
//           }
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.redAccent[400],
//       ),
//     );
//   }
// }
//endregion

//region 2
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'add_user.dart';
// import 'edit_user.dart';
// import 'login_screen.dart';
// import 'user_class.dart';
// import 'user_details.dart';
// import 'user_data.dart';
// import 'database_helper.dart';
// import 'api_service.dart'; // Import the ApiService
//
// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }
//
// class _UserListPageState extends State<UserListPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController searchController = TextEditingController();
//   List<User> filteredUsers = [];
//   List<User> userList = [];
//   String userName = 'Guest';
//   String userEmail = 'guest@example.com';
//   final ApiService apiService = ApiService(); // Initialize ApiService
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userName = prefs.getString('userName') ?? 'Guest';
//       userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
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
//   // Future<void> _loadUsers() async {
//   //   try {
//   //     // Fetch users from API
//   //     List<User> apiUsers = await apiService.getUsers();
//   //
//   //     if (mounted) {
//   //       setState(() {
//   //         apiUsers.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//   //         userList = apiUsers;
//   //         filteredUsers = List.from(userList);
//   //       });
//   //     }
//   //
//   //     // Optional: Sync with local database
//   //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
//   //     for (var user in apiUsers) {
//   //       await databaseHelper.insertUser(user); // Insert or update in local DB
//   //     }
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Error loading users from API: $e')),
//   //       );
//   //
//   //       // Fallback to local database if API fails
//   //       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//   //       List<User> localUsers = await databaseHelper.fetchUsers();
//   //       if (mounted) {
//   //         setState(() {
//   //           localUsers.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//   //           userList = localUsers;
//   //           filteredUsers = List.from(userList);
//   //         });
//   //       }
//   //     }
//   //   }
//   // }
//   // Future<void> _loadUsers() async {
//   //   try {
//   //     List<User> apiUsers = await apiService.getUsers();
//   //     print("API Users: ${apiUsers.map((u) => u.toJson()).toList()}"); // Debug print
//   //
//   //     if (mounted) {
//   //       setState(() {
//   //         apiUsers.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//   //         userList = apiUsers;
//   //         filteredUsers = List.from(userList);
//   //       });
//   //     }
//   //
//   //     // Optional: Sync with local database
//   //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
//   //     for (var user in apiUsers) {
//   //       await databaseHelper.insertUser(user);
//   //     }
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Error loading users from API: $e')),
//   //       );
//   //
//   //       // Fallback to local database
//   //       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//   //       List<User> localUsers = await databaseHelper.fetchUsers();
//   //       print("Local Users: ${localUsers.map((u) => u.toJson()).toList()}"); // Debug print
//   //       if (mounted) {
//   //         setState(() {
//   //           localUsers.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//   //           userList = localUsers;
//   //           filteredUsers = List.from(userList);
//   //         });
//   //       }
//   //     }
//   //   }
//   // }
//   Future<void> _loadUsers() async {
//     try {
//       print('Fetching users from API...');
//       List<User> apiUsers = await apiService.getUsers();
//       print("API Users: ${apiUsers.map((u) => u.toJson()).toList()}");
//
//       if (mounted) {
//         setState(() {
//           apiUsers.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//           userList = apiUsers;
//           filteredUsers = List.from(userList);
//         });
//       }
//
//       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//       for (var user in apiUsers) {
//         await databaseHelper.insertUser(user);
//       }
//     } catch (e) {
//       print('API Error: $e'); // Log the exact error
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading users from API: $e')),
//         );
//
//         DatabaseHelper databaseHelper = DatabaseHelper.instance;
//         List<User> localUsers = await databaseHelper.fetchUsers();
//         print("Local Users: ${localUsers.map((u) => u.toJson()).toList()}");
//         if (mounted) {
//           setState(() {
//             localUsers.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
//             userList = localUsers;
//             filteredUsers = List.from(userList);
//           });
//         }
//       }
//     }
//   }
//
//   void _filterUsers(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredUsers = List.from(userList);
//       } else {
//         filteredUsers = userList.where((user) {
//           String name = user.name?.toLowerCase() ?? '';
//           String city = user.city?.toLowerCase() ?? '';
//           String email = user.email?.toLowerCase() ?? '';
//           String phone = user.phone?.toLowerCase() ?? '';
//           String age = user.age?.toString() ?? '';
//
//           query = query.toLowerCase();
//
//           return name.contains(query) ||
//               city.contains(query) ||
//               email.contains(query) ||
//               phone.contains(query) ||
//               age.contains(query);
//         }).toList();
//       }
//     });
//   }
//
//   void _editUser(User user) async {
//     final updatedUser = await Navigator.push<User>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditUserPage(user: user),
//       ),
//     );
//
//     if (updatedUser != null) {
//       try {
//         // Update in database
//         await DatabaseHelper.instance.updateUser(updatedUser);
//
//         // Update in local lists
//         setState(() {
//           int index = userList.indexWhere((u) => u.id == updatedUser.id);
//           if (index != -1) {
//             userList[index] = updatedUser;
//             // Update filtered list as well
//             filteredUsers = List.from(userList);
//           }
//         });
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating user: $e')),
//         );
//       }
//     }
//   }
//
//   void _toggleFavorite(User user) async {
//     if (user.isFavorite) {
//       bool? confirmUnfavorite = await showDialog<bool>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Confirm Unfavorite',
//                 style: GoogleFonts.poppins(fontSize: 16)),
//             content: Text('Are you sure you want to unfavorite this user?',
//                 style: GoogleFonts.poppins(fontSize: 14)),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false); // User chose to cancel
//                 },
//                 child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true); // User confirmed unfavorite
//                 },
//                 child: Text('Unfavorite',
//                     style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//             ],
//           );
//         },
//       );
//
//       if (confirmUnfavorite == true) {
//         DatabaseHelper databaseHelper = DatabaseHelper.instance;
//         bool newFavoriteStatus = !user.isFavorite;
//         setState(() {
//           user.isFavorite = newFavoriteStatus;
//         });
//         await databaseHelper.updateUser(user);
//       }
//     } else {
//       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//       bool newFavoriteStatus = !user.isFavorite;
//       setState(() {
//         user.isFavorite = newFavoriteStatus;
//       });
//       await databaseHelper.updateUser(user);
//     }
//   }
//
//   void _confirmDelete(User user) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion',
//               style: GoogleFonts.poppins(fontSize: 16)),
//           content: Text('Are you sure you want to delete this user?',
//               style: GoogleFonts.poppins(fontSize: 14)),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//             ),
//             TextButton(
//               onPressed: () async {
//                 try {
//                   await apiService.deleteUser(user.id!);
//                   DatabaseHelper databaseHelper = DatabaseHelper.instance;
//                   await databaseHelper.deleteUser(user.id!);
//
//                   setState(() {
//                     userList.remove(user);
//                     filteredUsers = List.from(userList);
//                   });
//
//                   Navigator.of(context).pop();
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error deleting user: $e')),
//                   );
//                 }
//               },
//               child: Text('Delete', style: GoogleFonts.poppins(fontSize: 14)),
//             ),
//           ],
//         );
//     });
//   }
//
//   String selectedSortBy = 'name';
//   String selectedOrder = 'asc';
//
//   void _openFilterDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               title: Text(
//                 'Filter & Sort Users',
//                 style: GoogleFonts.poppins(
//                     fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Sort by:',
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, fontWeight: FontWeight.w600),
//                       ),
//                       DropdownButton<String>(
//                         value: selectedSortBy,
//                         items: [
//                           DropdownMenuItem(
//                             value: 'name',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.person,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Name',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'age',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.cake_rounded,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Age',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'gender',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.people_alt_rounded,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Gender',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             selectedSortBy = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Order:',
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, fontWeight: FontWeight.w600),
//                       ),
//                       DropdownButton<String>(
//                         value: selectedOrder,
//                         items: [
//                           DropdownMenuItem(
//                             value: 'asc',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.arrow_upward,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Ascending',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                           DropdownMenuItem(
//                             value: 'desc',
//                             child: Row(
//                               children: [
//                                 Icon(Icons.arrow_downward,
//                                     size: 18, color: Colors.blue),
//                                 SizedBox(width: 8),
//                                 Text('Descending',
//                                     style: GoogleFonts.poppins(fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             selectedOrder = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.red,
//                   ),
//                   child:
//                   Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _applyFilterSort(selectedSortBy, selectedOrder);
//                     Navigator.of(context).pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent[400],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                   child: Text('Apply',
//                       style: GoogleFonts.poppins(
//                           fontSize: 14, color: Colors.white)),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _navigateToDetails(User user) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UserDetailsPage(
//           user: user,
//           onUpdate: (updatedUser) {
//             _loadUsers();
//           },
//           onDelete: (userToDelete) {
//             _confirmDelete(userToDelete);
//           },
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
//         child: Icon(icon, color: Colors.redAccent, size: 24),
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
//
//   Widget _buildUserCard(User user) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () => _navigateToDetails(user),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(3),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Colors.redAccent,
//                                 width: 2,
//                               ),
//                             ),
//                             child: CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.grey[200],
//                               child: ClipOval(
//                                 child: Image.asset(
//                                   user.gender?.toLowerCase() == 'male'
//                                       ? 'assets/images/male_avatar.png'
//                                       : 'assets/images/female_avatar3.png',
//                                   fit: BoxFit.cover,
//                                   height: 60,
//                                   width: 60,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Icon(Icons.person, size: 40);
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   user.name!,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 Text(
//                                   "${user.occupation}",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               user.isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: user.isFavorite
//                                   ? Colors.red
//                                   : Colors.grey[400],
//                               size: 28,
//                             ),
//                             onPressed: () => _toggleFavorite(user),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       _buildInfoRow(Icons.cake_rounded,
//                           "${user.age ?? 'N/A'} years", Colors.purple),
//                       SizedBox(height: 8),
//                       _buildInfoRow(Icons.location_on_rounded,
//                           user.city ?? 'N/A', Colors.blue),
//                       SizedBox(height: 8),
//                       _buildInfoRow(Icons.email_rounded, user.email ?? 'N/A',
//                           Colors.orange),
//                       SizedBox(height: 8),
//                       _buildInfoRow(Icons.phone_rounded, user.phone ?? 'N/A',
//                           Colors.green),
//                     ],
//                   ),
//                 ),
//                 Divider(height: 1),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildActionButton(
//                         icon: Icons.edit_rounded,
//                         label: 'Edit',
//                         color: Colors.blue,
//                         onTap: () => _editUser(user),
//                       ),
//                       Container(
//                         width: 1,
//                         height: 24,
//                         color: Colors.grey[300],
//                       ),
//                       _buildActionButton(
//                         icon: Icons.delete_rounded,
//                         label: 'Delete',
//                         color: Colors.red,
//                         onTap: () => _confirmDelete(user),
//                       ),
//                     ],
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
//   Widget _buildInfoRow(IconData icon, String text, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: color),
//         SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             text,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           children: [
//             Icon(icon, size: 20, color: color),
//             SizedBox(width: 8),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 color: color,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text(
//           'User List',
//           style: GoogleFonts.poppins(
//               fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent[400],
//         elevation: 5,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(Icons.menu_open_rounded, color: Colors.white),
//           ),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list, color: Colors.white),
//             onPressed: _openFilterDialog,
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
//                           backgroundImage:
//                           AssetImage("assets/images/image.png"),
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
//                 _buildDrawerItem(
//                   icon: Icons.home_rounded,
//                   title: "Home",
//                   onTap: () => Navigator.pushNamed(context, '/dashboard'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.person_add_alt_1_rounded,
//                   title: "Create Profiles",
//                   onTap: () => Navigator.pushNamed(context, '/addUser'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.favorite_rounded,
//                   title: "Favourites Profiles",
//                   onTap: () => Navigator.pushNamed(context, '/favourites'),
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.info_rounded,
//                   title: "About Us",
//                   onTap: () => Navigator.pushNamed(context, '/aboutUs'),
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
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.redAccent.shade400,
//               Colors.red.shade50,
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: MediaQuery.of(context).padding.top + 56 + 16),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: _filterUsers,
//                   decoration: InputDecoration(
//                     hintText: 'Search profiles...',
//                     hintStyle: GoogleFonts.poppins(color: Colors.grey),
//                     prefixIcon:
//                     Icon(Icons.search_rounded, color: Colors.redAccent),
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.only(bottom: 100),
//                 itemCount: filteredUsers.length,
//                 itemBuilder: (context, index) =>
//                     _buildUserCard(filteredUsers[index]),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           User? newUser = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddUserPage(),
//             ),
//           );
//
//           if (newUser != null) {
//             try {
//               // Create user via API
//               User createdUser = await apiService.createUser(newUser.toJson());
//               setState(() {
//                 userList.insert(0, createdUser);
//                 filteredUsers = List.from(userList);
//               });
//
//               // Optional: Save to local database
//               DatabaseHelper databaseHelper = DatabaseHelper.instance;
//               await databaseHelper.insertUser(createdUser);
//             } catch (e) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Error creating user: $e')),
//               );
//             }
//           }
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.redAccent[400],
//       ),
//     );
//   }
// }

//endregion

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_user.dart';
import 'edit_user.dart';
import 'login_screen.dart';
import 'user_class.dart';
import 'user_details.dart';
import 'user_data.dart';
import 'database_helper.dart';
import 'package:matrimony_app/api_service.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();
  TextEditingController searchController = TextEditingController();
  List<User> filteredUsers = [];
  List<User> userList = [];
  String userName = 'Guest';
  String userEmail = 'guest@example.com';

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
    });
  }

  // void _loadUsers() async {
  //   try {
  //     print('Fetching users from API...');
  //     List<User> apiUsers = await _apiService.fetchUsers();
  //     print('API fetch successful. Users fetched: ${apiUsers.length}');
  //
  //     if (apiUsers.isNotEmpty) {
  //       print('Saving users to local database...');
  //       DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //       for (User user in apiUsers) {
  //         await databaseHelper.insertUser(user);
  //       }
  //       print('Users saved to database.');
  //     }
  //
  //     print('Loading users from local database...');
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     List<User> users = await databaseHelper.fetchUsers();
  //     print('Users loaded from database: ${users.length}');
  //
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //   } catch (e, stackTrace) {
  //     print('Error loading users: $e');
  //     print('Stack trace: $stackTrace');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading users: $e')),
  //     );
  //   }
  // }
  // void _loadUsers() async {
  //   try {
  //     print('Fetching users from API...');
  //     List<User> apiUsers = await _apiService.fetchUsers();
  //     print('API Users: ${apiUsers.length}');
  //
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     if (apiUsers.isNotEmpty) {
  //       for (User user in apiUsers) {
  //         await databaseHelper.insertUser(user);
  //       }
  //     }
  //
  //     List<User> users = await databaseHelper.fetchUsers();
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //   } catch (e) {
  //     print('Error loading users: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading API data: $e')),
  //     );
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     List<User> users = await databaseHelper.fetchUsers();
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //     if (users.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('No local data available')),
  //       );
  //     }
  //   }
  // }
  // void _loadUsers() async {
  //   try {
  //     print('Fetching users from API...');
  //     List<User> apiUsers = await _apiService.fetchUsers();
  //     print('API Users: ${apiUsers.length}');
  //
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //
  //     // Step 1: Fetch existing local users to preserve their favorite status
  //     List<User> localUsers = await databaseHelper.fetchUsers();
  //     Map<int, User> localUserMap = {
  //       for (var user in localUsers) user.id!: user
  //     };
  //
  //     // Step 2: Update or insert API users into the database
  //     if (apiUsers.isNotEmpty) {
  //       for (User apiUser in apiUsers) {
  //         // If the user already exists locally, preserve the favorite status
  //         if (localUserMap.containsKey(apiUser.id)) {
  //           apiUser.isFavorite = localUserMap[apiUser.id]!.isFavorite;
  //         }
  //         await databaseHelper.insertUser(apiUser); // This will update or insert
  //       }
  //     }
  //
  //     // Step 3: Fetch the updated list from the database
  //     List<User> users = await databaseHelper.fetchUsers();
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //   } catch (e) {
  //     print('Error loading users: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading API data: $e')),
  //     );
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     List<User> users = await databaseHelper.fetchUsers();
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //     if (users.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('No local data available')),
  //       );
  //     }
  //   }
  // }

  //Working for API and storing in database
  // void _loadUsers() async {
  //   try {
  //     print('Fetching users from API...');
  //     List<User> apiUsers = await _apiService.fetchUsers();
  //     print('API Users: ${apiUsers.length}');

  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;

  //     // Step 1: Fetch existing local users to preserve their edits
  //     List<User> localUsers = await databaseHelper.fetchUsers();
  //     Map<int, User> localUserMap = {for (var user in localUsers) user.id!: user};

  //     // Step 2: Merge API users with local users
  //     if (apiUsers.isNotEmpty) {
  //       for (User apiUser in apiUsers) {
  //         if (localUserMap.containsKey(apiUser.id)) {
  //           // Preserve local edits for fields that might have been modified
  //           User localUser = localUserMap[apiUser.id]!;
  //           apiUser.name = localUser.name; // Keep local name
  //           apiUser.dob = localUser.dob; // Keep local dob
  //           apiUser.maritalStatus = localUser.maritalStatus;
  //           apiUser.country = localUser.country;
  //           apiUser.state = localUser.state;
  //           apiUser.religion = localUser.religion;
  //           apiUser.caste = localUser.caste;
  //           apiUser.subCaste = localUser.subCaste;
  //           apiUser.education = localUser.education;
  //           apiUser.gender = localUser.gender;
  //           apiUser.city = localUser.city;
  //           apiUser.email = localUser.email;
  //           apiUser.phone = localUser.phone;
  //           apiUser.occupation = localUser.occupation;
  //           apiUser.isFavorite = localUser.isFavorite; // Preserve favorite status
  //         }
  //         // Insert or update the merged user in the database
  //         await databaseHelper.insertUser(apiUser);
  //       }
  //     }

  //     // Step 3: Fetch the updated list from the database
  //     List<User> users = await databaseHelper.fetchUsers();
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //   } catch (e) {
  //     print('Error loading users: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading API data: $e')),
  //     );
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     List<User> users = await databaseHelper.fetchUsers();
  //     setState(() {
  //       users.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
  //       userList = users;
  //       filteredUsers = List.from(userList);
  //     });
  //     if (users.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('No local data available')),
  //       );
  //     }
  //   }
  // }
  // void _loadUsers() async {
  //   try {
  //     print('Fetching users from API...');
  //     List<User> apiUsers = await _apiService.fetchUsers();
  //     print('API Users: ${apiUsers.length}');

  //     setState(() {
  //       // Sort by ID and update the lists
  //       apiUsers.sort((a, b) {
  //         // Convert string IDs to integers for comparison
  //         int idA = int.tryParse(a.id ?? '0') ?? 0;
  //         int idB = int.tryParse(b.id ?? '0') ?? 0;
  //         return idB.compareTo(idA); // Sort in descending order
  //       });
  //       userList = apiUsers;
  //       filteredUsers = List.from(userList);
  //     });
  //   } catch (e) {
  //     print('Error loading users: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading API data: $e')),
  //     );
  //   }
  // }
  void _loadUsers() async {
    try {
      setState(() {
        _isLoading = true;
      });

      print('Fetching users from API...');
      List<User> apiUsers = await _apiService.fetchUsers();
      print('API Users: ${apiUsers.length}');

      if (mounted) {
        setState(() {
          apiUsers.sort((a, b) {
            int idA = int.tryParse(a.id ?? '0') ?? 0;
            int idB = int.tryParse(b.id ?? '0') ?? 0;
            return idB.compareTo(idA);
          });
          userList = apiUsers;
          filteredUsers = List.from(userList);
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading users: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading API data: $e')),
        );
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure you want to logout?"),
          content: const Text("You will be logged out of the app."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
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
              child: const Text("Yes"),
            ),
          ],
        );
      },
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
        child: Icon(icon, color: Colors.redAccent, size: 24),
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

  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(userList);
      } else {
        filteredUsers = userList.where((user) {
          String name = user.name?.toLowerCase() ?? '';
          String city = user.city?.toLowerCase() ?? '';
          String email = user.email?.toLowerCase() ?? '';
          String phone = user.phone?.toLowerCase() ?? '';
          String age = user.age.toString() ?? '';

          query = query.toLowerCase();

          return name.contains(query) ||
              city.contains(query) ||
              email.contains(query) ||
              phone.contains(query) ||
              age.contains(query);
        }).toList();
      }
    });
  }

  void _editUser(User user) async {
    User? updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(user: user),
      ),
    );

    if (updatedUser != null) {
      // DatabaseHelper databaseHelper = DatabaseHelper.instance;
      // await databaseHelper
      //     .updateUser(updatedUser);
      await _apiService.updateUser(updatedUser.toJson());
      setState(() {
        int index = userList.indexWhere((u) => u.id == updatedUser.id);
        if (index != -1) {
          userList[index] = updatedUser;
        }
        filteredUsers = List.from(userList);
      });
    }
  }

  // void _toggleFavorite(User user) async {
  //   if (user.isFavorite) {
  //     bool? confirmUnfavorite = await showDialog<bool>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Confirm Unfavorite',
  //               style: GoogleFonts.poppins(fontSize: 16)),
  //           content: Text('Are you sure you want to unfavorite this user?',
  //               style: GoogleFonts.poppins(fontSize: 14)),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(false); // User chose to cancel
  //               },
  //               child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(true); // User confirmed unfavorite
  //               },
  //               child: Text('Unfavorite',
  //                   style: GoogleFonts.poppins(fontSize: 14)),
  //             ),
  //           ],
  //         );
  //       },
  //     );

  //     if (confirmUnfavorite == true) {
  //       DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //       bool newFavoriteStatus = !user.isFavorite;
  //       setState(() {
  //         user.isFavorite = newFavoriteStatus;
  //       });
  //       // await databaseHelper.updateUser(user);
  //       await _apiService.updateUser(user.toJson());
  //     }
  //   } else {
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     bool newFavoriteStatus = !user.isFavorite;
  //     setState(() {
  //       user.isFavorite = newFavoriteStatus;
  //     });
  //     await databaseHelper.updateUser(user);
  //   }
  // }
  void _toggleFavorite(User user) async {
    if (user.isFavorite) {
      bool? confirmUnfavorite = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Unfavorite',
                style: GoogleFonts.poppins(fontSize: 16)),
            content: Text('Are you sure you want to unfavorite this user?',
                style: GoogleFonts.poppins(fontSize: 14)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Unfavorite',
                    style: GoogleFonts.poppins(fontSize: 14)),
              ),
            ],
          );
        },
      );

      if (confirmUnfavorite == true) {
        try {
          user.isFavorite = false;

          await _apiService.updateUser(user.toJson());

          setState(() {});

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Removed from favorites')),
          );
        } catch (e) {
          user.isFavorite = true;
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update favorite status: $e')),
          );
        }
      }
    } else {
      try {
        user.isFavorite = true;

        await _apiService.updateUser(user.toJson());

        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added to favorites')),
        );
      } catch (e) {
        user.isFavorite = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favorite status: $e')),
        );
      }
    }
  }

  void _confirmDelete(User user) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion',
              style: GoogleFonts.poppins(fontSize: 16)),
          content: Text('Are you sure you want to delete this user?',
              style: GoogleFonts.poppins(fontSize: 14)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            TextButton(
              onPressed: () async {
                DatabaseHelper databaseHelper = DatabaseHelper.instance;
                // await databaseHelper
                //     .deleteUser(user.id!); // Delete using user ID
                await _apiService.deleteUser(user.id!);

                setState(() {
                  userList.remove(user);
                  filteredUsers =
                      List.from(userList);
                });

                Navigator.of(context).pop();
              },
              child: Text('Delete', style: GoogleFonts.poppins(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  void _applyFilterSort(String sortBy, String order) {
    setState(() {
      filteredUsers.sort((a, b) {
        int comparison = 0;

        switch (sortBy) {
          case 'name':
            comparison = a.name!.compareTo(b.name!);
            break;
          case 'age':
            comparison = a.age.compareTo(b.age);
            break;
          case 'gender':
            comparison = a.gender!.compareTo(b.gender!);
            break;
        }
        return order == 'asc' ? comparison : -comparison;
      });
    });
  }

  String selectedSortBy = 'name';
  String selectedOrder = 'asc';

  void _openFilterDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              title: Text(
                'Filter & Sort Users',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sort by:',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      DropdownButton<String>(
                        value: selectedSortBy,
                        items: [
                          DropdownMenuItem(
                            value: 'name',
                            child: Row(
                              children: [
                                const Icon(Icons.person,
                                    size: 18, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text('Name',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'age',
                            child: Row(
                              children: [
                                const Icon(Icons.cake_rounded,
                                    size: 18, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text('Age',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'gender',
                            child: Row(
                              children: [
                                const Icon(Icons.people_alt_rounded,
                                    size: 18, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text('Gender',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedSortBy = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order:',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      DropdownButton<String>(
                        value: selectedOrder,
                        items: [
                          DropdownMenuItem(
                            value: 'asc',
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_upward,
                                    size: 18, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text('Ascending',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'desc',
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_downward,
                                    size: 18, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text('Descending',
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedOrder = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child:
                      Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _applyFilterSort(selectedSortBy, selectedOrder);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Text('Apply',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildUserCard(User user) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _navigateToDetails(user),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.redAccent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[200],
                              child: ClipOval(
                                child: Image.asset(
                                  user.gender == 'Male'
                                      ? 'assets/images/male_avatar.png'
                                      : 'assets/images/female_avatar3.png',
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "${user.occupation}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              user.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: user.isFavorite
                                  ? Colors.red
                                  : Colors.grey[400],
                              size: 28,
                            ),
                            onPressed: () => _toggleFavorite(user),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow(Icons.cake_rounded, "${user.age} years",
                          Colors.purple),
                      SizedBox(height: 8),
                      _buildInfoRow(Icons.location_on_rounded, user.city ?? '',
                          Colors.blue),
                      SizedBox(height: 8),
                      _buildInfoRow(
                          Icons.email_rounded, user.email ?? '', Colors.orange),
                      SizedBox(height: 8),
                      _buildInfoRow(
                          Icons.phone_rounded, user.phone ?? '', Colors.green),
                    ],
                  ),
                ),
                Divider(height: 1),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.edit_rounded,
                        label: 'Edit',
                        color: Colors.blue,
                        onTap: () => _editUser(user),
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        color: Colors.grey[300],
                      ),
                      _buildActionButton(
                        icon: Icons.delete_rounded,
                        label: 'Delete',
                        color: Colors.red,
                        onTap: () => _confirmDelete(user),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
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
            'Profiles',
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
              child: Icon(Icons.menu_open_rounded, color: Colors.white),
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(Icons.filter_list_rounded, color: Colors.white),
                onPressed: _openFilterDialog,
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
                    padding: const EdgeInsets.symmetric(vertical: 30),
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
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/image.png"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          userName,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
                  _buildDrawerItem(
                    icon: Icons.home_rounded,
                    title: "Home",
                    onTap: () => Navigator.pushNamed(context, '/dashboard'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_add_alt_1_rounded,
                    title: "Create Profiles",
                    onTap: () => Navigator.pushNamed(context, '/addUser'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_rounded,
                    title: "Favourites Profiles",
                    onTap: () => Navigator.pushNamed(context, '/favourites'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_rounded,
                    title: "About Us",
                    onTap: () => Navigator.pushNamed(context, '/aboutUs'),
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.redAccent.shade400,
                Colors.red.shade50,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 56 + 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: _filterUsers,
                    decoration: InputDecoration(
                      hintText: 'Search profiles...',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      prefixIcon:
                          Icon(Icons.search_rounded, color: Colors.redAccent),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Expanded(
              //   child: ListView.builder(
              //     padding: EdgeInsets.only(bottom: 100),
              //     itemCount: filteredUsers.length,
              //     itemBuilder: (context, index) =>
              //         _buildUserCard(filteredUsers[index]),
              //   ),
              // ),
              Expanded(
                child: _isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.redAccent),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Loading profiles...',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : filteredUsers.isEmpty
                        ? Center(
                            child: Text(
                              'No profiles found',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 100),
                            itemCount: filteredUsers.length,
                            itemBuilder: (context, index) =>
                                _buildUserCard(filteredUsers[index]),
                          ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [Colors.redAccent.shade400, Colors.redAccent.shade700],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () async {
              final User? newUser = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserPage()),
              );

              if (newUser != null) {
                setState(() {
                  // Add the new user to both lists
                  userList.insert(0, newUser);
                  filteredUsers = List.from(userList);
                });

                // Show confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('New profile added successfully!')),
                );
              }
            },
            child: Icon(Icons.add_rounded, size: 28),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(
          user: user,
          onUpdate: (updatedUser) {
            setState(() {
              userList[userList.indexOf(user)] = updatedUser;
              filteredUsers = List.from(userList);
            });
          },
          onDelete: (deletedUser) {
            setState(() {
              userList.remove(deletedUser);
              filteredUsers = List.from(userList);
            });
          },
        ),
      ),
    );
  }
}
