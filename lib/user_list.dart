// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'add_user.dart';
// import 'edit_user.dart';
// import 'user_class.dart';
// import 'user_details.dart';
// import 'user_data.dart';
//
// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }
//
// class _UserListPageState extends State<UserListPage> {
//   TextEditingController searchController = TextEditingController();
//   List<User> filteredUsers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredUsers = List.from(userList);
//   }
//
//   void _filterUsers(String query) {
//     setState(() {
//       filteredUsers = userList.where((user) {
//         String name = user.name?.toLowerCase() ?? '';
//         String city = user.city?.toLowerCase() ?? '';
//         String email = user.email?.toLowerCase() ?? '';
//         String phone = user.phone?.toLowerCase() ?? '';
//         String age = user.age?.toString() ?? ''; // Ensure age is a string
//
//         query = query.toLowerCase(); // Convert query to lowercase
//
//         return name.contains(query) ||
//             city.contains(query) ||
//             email.contains(query) ||
//             phone.contains(query) ||
//             age.contains(query);
//       }).toList();
//     });
//   }
//
//   // void _toggleFavorite(User user) {
//   //   setState(() {
//   //     user.isFavorite = !user.isFavorite;
//   //   });
//   // }
//
//   void _toggleFavorite(User user) {
//     if (user.isFavorite) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Confirm Unfavorite', style: GoogleFonts.poppins(fontSize: 16)),
//             content: Text('Are you sure you want to remove this user from your favorites?', style: GoogleFonts.poppins(fontSize: 14)),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     user.isFavorite = !user.isFavorite;
//                   });
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       setState(() {
//         user.isFavorite = !user.isFavorite;
//       });
//     }
//   }
//
//   void _editUser(User user) async {
//     User? updatedUser = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditUserPage(user: user),
//       ),
//     );
//
//     if (updatedUser != null) {
//       setState(() {
//         int userIndex = userList.indexOf(user);
//         if (userIndex != -1) {
//           userList[userIndex] = updatedUser;
//         }
//       });
//     }
//   }
//
//   void _confirmDelete(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion', style: GoogleFonts.poppins(fontSize: 16)),
//           content: Text('Are you sure you want to delete this user?', style: GoogleFonts.poppins(fontSize: 14)),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   userList.removeAt(index);
//                   filteredUsers = List.from(userList);
//                 });
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
//   // void _addNewUser() async {
//   //   User? newUser = await Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => AddUserPage(),
//   //     ),
//   //   );
//   //
//   //   if (newUser != null) {
//   //     setState(() {
//   //       userList.add(newUser);
//   //       filteredUsers = List.from(userList);
//   //     });
//   //   }
//   // }
//
//   void _addNewUser() async {
//     User? newUser = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddUserPage(),
//       ),
//     );
//
//     if (newUser != null) {
//       setState(() {
//         userList.insert(0, newUser);
//         filteredUsers = List.from(userList);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('User List', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
//       //   backgroundColor: Colors.redAccent,
//       //   elevation: 5,
//       //   centerTitle: true,
//       // ),
//       appBar: AppBar(
//         title: Text(
//           'User List',
//           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent,
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
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white,
//               Colors.red.shade300,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               // child: TextField(
//               //   controller: searchController,
//               //   onChanged: _filterUsers,
//               //   decoration: InputDecoration(
//               //     labelText: 'Search User',
//               //     labelStyle: GoogleFonts.poppins(color: Colors.redAccent),
//               //     prefixIcon: Icon(Icons.search, color: Colors.redAccent),
//               //     border: OutlineInputBorder(
//               //       borderRadius: BorderRadius.circular(12),
//               //       borderSide: BorderSide(color: Colors.redAccent),
//               //     ),
//               //     filled: true,
//               //     fillColor: Colors.white,
//               //   ),
//               // ),
//               child: SizedBox(
//                 width: double.infinity, // Ensures full width
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         spreadRadius: 2,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     onChanged: _filterUsers,
//                     decoration: InputDecoration(
//                       labelText: 'Search User',
//                       labelStyle: GoogleFonts.poppins(color: Colors.redAccent),
//                       prefixIcon: Icon(Icons.search, color: Colors.redAccent),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredUsers.length,
//                 itemBuilder: (context, index) {
//                   User user = filteredUsers[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     elevation: 5,
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(15),
//                       title: Text(
//                         user.name!,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("State: ${user.city}",
//                               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("Phone: ${user.phone}",
//                               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("Email: ${user.email}",
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("DOB: ${user.dob}",
//                               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("Age: ${user.age}",
//                               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               user.isFavorite ? Icons.favorite : Icons.favorite_border,
//                               color: user.isFavorite ? Colors.red : Colors.grey,
//                             ),
//                             onPressed: () => _toggleFavorite(user),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () => _editUser(user),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => _confirmDelete(index),
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => UserDetailsPage(
//                               user: user,
//                               onUpdate: (updatedUser) {
//                                 setState(() {
//                                   userList[userList.indexOf(user)] = updatedUser;
//                                   filteredUsers = List.from(userList);
//                                 });
//                               },
//                               onDelete: (deletedUser) {
//                                 setState(() {
//                                   userList.remove(deletedUser);
//                                   filteredUsers = List.from(userList);
//                                 });
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addNewUser,
//         child: Icon(Icons.add),
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_user.dart';
import 'edit_user.dart';
import 'user_class.dart';
import 'user_details.dart';
import 'user_data.dart';
import 'database_helper.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

// class _UserListPageState extends State<UserListPage> {
//   TextEditingController searchController = TextEditingController();
//   List<User> filteredUsers = [];
//   List<User> userList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();  // Load users from the database when the page initializes
//   }
//
//   void _loadUsers() async {
//     DatabaseHelper databaseHelper = DatabaseHelper.instance;
//     List<User> users = await databaseHelper.fetchUsers();  // Fetch users from the database
//     setState(() {
//       userList = users;
//       filteredUsers = List.from(userList);
//     });
//   }
//
//   void _filterUsers(String query) {
//     setState(() {
//       filteredUsers = userList.where((user) {
//         String name = user.name?.toLowerCase() ?? '';
//         String city = user.city?.toLowerCase() ?? '';
//         String email = user.email?.toLowerCase() ?? '';
//         String phone = user.phone?.toLowerCase() ?? '';
//         String age = user.age?.toString() ?? ''; // Ensure age is a string
//
//         query = query.toLowerCase(); // Convert query to lowercase
//
//         return name.contains(query) ||
//             city.contains(query) ||
//             email.contains(query) ||
//             phone.contains(query) ||
//             age.contains(query);
//       }).toList();
//     });
//   }
//
//   void _addNewUser() async {
//     User? newUser = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddUserPage(),
//       ),
//     );
//
//     if (newUser != null) {
//       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//       await databaseHelper.insertUser(newUser);  // Insert user into database
//       _loadUsers();  // Reload the list after inserting
//     }
//   }
//
//   void _editUser(User user) async {
//     User? updatedUser = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditUserPage(user: user),
//       ),
//     );
//
//     if (updatedUser != null) {
//       DatabaseHelper databaseHelper = DatabaseHelper.instance;
//       await databaseHelper.updateUser(updatedUser);
//       _loadUsers();
//     }
//   }
//
//   // void _toggleFavorite(User user) async {
//   //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
//   //   bool newFavoriteStatus = !user.isFavorite;
//   //   setState(() {
//   //     user.isFavorite = newFavoriteStatus;
//   //   });
//   //   user.isFavorite = newFavoriteStatus;
//   //   await databaseHelper.updateUser(user);
//   // }
//
//   void _toggleFavorite(User user) async {
//     // Check if the user is currently favorited, we only need confirmation to unfavorite.
//     if (user.isFavorite) {
//       // Show a confirmation dialog before unfavoriting
//       bool? confirmUnfavorite = await showDialog<bool>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Confirm Unfavorite', style: GoogleFonts.poppins(fontSize: 16)),
//             content: Text('Are you sure you want to unfavorite this user?', style: GoogleFonts.poppins(fontSize: 14)),
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
//                 child: Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
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
//   void _confirmDelete(int index) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion', style: GoogleFonts.poppins(fontSize: 16)),
//           content: Text('Are you sure you want to delete this user?', style: GoogleFonts.poppins(fontSize: 14)),
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
//                 await databaseHelper.deleteUser(userList[index].id!);  // Delete user from the database
//                 setState(() {
//                   userList.removeAt(index);
//                   filteredUsers = List.from(userList);  // Update the UI after deleting
//                 });
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'User List',
//           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
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
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade50, Colors.red.shade300],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         spreadRadius: 2,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     onChanged: _filterUsers,
//                     decoration: InputDecoration(
//                       labelText: 'Search User',
//                       labelStyle: GoogleFonts.poppins(color: Colors.redAccent),
//                       prefixIcon: Icon(Icons.search, color: Colors.redAccent),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredUsers.length,
//                 itemBuilder: (context, index) {
//                   User user = filteredUsers[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     elevation: 5,
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(15),
//                       title: Text(
//                         user.name!,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("State: ${user.city}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("Phone: ${user.phone}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("Email: ${user.email}", overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("DOB: ${user.dob}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                           Text("Age: ${user.age}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               user.isFavorite ? Icons.favorite : Icons.favorite_border,
//                               color: user.isFavorite ? Colors.red : Colors.grey,
//                             ),
//                             onPressed: () => _toggleFavorite(user),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () => _editUser(user),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => _confirmDelete(index),
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => UserDetailsPage(
//                               user: user,
//                               onUpdate: (updatedUser) {
//                                 setState(() {
//                                   userList[userList.indexOf(user)] = updatedUser;
//                                   filteredUsers = List.from(userList);
//                                 });
//                               },
//                               onDelete: (deletedUser) {
//                                 setState(() {
//                                   userList.remove(deletedUser);
//                                   filteredUsers = List.from(userList);
//                                 });
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addNewUser,
//         child: Icon(Icons.add),
//         backgroundColor: Colors.redAccent[400],
//       ),
//     );
//   }
// }

class _UserListPageState extends State<UserListPage> {
  TextEditingController searchController = TextEditingController();
  List<User> filteredUsers = [];
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List<User> users = await databaseHelper.fetchUsers();  // Fetch users from the database
    setState(() {
      userList = users;
      filteredUsers = List.from(userList);
    });
  }
  
  // void _filterUsers(String query) {
  //   setState(() {
  //     filteredUsers = userList.where((user) {
  //       String name = user.name?.toLowerCase() ?? '';
  //       String city = user.city?.toLowerCase() ?? '';
  //       String email = user.email?.toLowerCase() ?? '';
  //       String phone = user.phone?.toLowerCase() ?? '';
  //       String age = user.age?.toString() ?? '';
  //
  //       query = query.toLowerCase();
  //
  //       return name.contains(query) ||
  //           city.contains(query) ||
  //           email.contains(query) ||
  //           phone.contains(query) ||
  //           age.contains(query);
  //     }).toList();
  //   });
  // }
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
          String age = user.age?.toString() ?? '';

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

  // void _addNewUser() async {
  //   User? newUser = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AddUserPage(),
  //     ),
  //   );
  //
  //   if (newUser != null) {
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     await databaseHelper.insertUser(newUser);
  //     _loadUsers();
  //   }
  // }

  void _editUser(User user) async {
    User? updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(user: user),
      ),
    );

    if (updatedUser != null) {
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      await databaseHelper.updateUser(updatedUser);
      _loadUsers();
    }
  }

  // void _toggleFavorite(User user) async {
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //   bool newFavoriteStatus = !user.isFavorite;
  //   setState(() {
  //     user.isFavorite = newFavoriteStatus;
  //   });
  //   user.isFavorite = newFavoriteStatus;
  //   await databaseHelper.updateUser(user);
  // }

  void _toggleFavorite(User user) async {
    if (user.isFavorite) {
      bool? confirmUnfavorite = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Unfavorite', style: GoogleFonts.poppins(fontSize: 16)),
            content: Text('Are you sure you want to unfavorite this user?', style: GoogleFonts.poppins(fontSize: 14)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User chose to cancel
                },
                child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirmed unfavorite
                },
                child: Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
              ),
            ],
          );
        },
      );

      if (confirmUnfavorite == true) {
        DatabaseHelper databaseHelper = DatabaseHelper.instance;
        bool newFavoriteStatus = !user.isFavorite;
        setState(() {
          user.isFavorite = newFavoriteStatus;
        });
        await databaseHelper.updateUser(user);
      }
    } else {
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      bool newFavoriteStatus = !user.isFavorite;
      setState(() {
        user.isFavorite = newFavoriteStatus;
      });
      await databaseHelper.updateUser(user);
    }
  }

  // void _confirmDelete(int index) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Confirm Deletion', style: GoogleFonts.poppins(fontSize: 16)),
  //         content: Text('Are you sure you want to delete this user?', style: GoogleFonts.poppins(fontSize: 14)),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //               await databaseHelper.deleteUser(userList[index].id!);
  //               setState(() {
  //                 userList.removeAt(index);
  //                 filteredUsers = List.from(userList);  // Update the UI after deleting
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Delete', style: GoogleFonts.poppins(fontSize: 14)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _confirmDelete(User user) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion', style: GoogleFonts.poppins(fontSize: 16)),
          content: Text('Are you sure you want to delete this user?', style: GoogleFonts.poppins(fontSize: 14)),
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
                await databaseHelper.deleteUser(user.id!);  // Delete using user ID

                // Remove from both lists (userList and filteredUsers)
                setState(() {
                  userList.remove(user);
                  filteredUsers = List.from(userList);  // Update the UI after deleting
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

        // Compare based on selected sorting field
        switch (sortBy) {
          case 'name':
            comparison = a.name!.compareTo(b.name!);
            break;
          case 'age':
            comparison = a.age!.compareTo(b.age!);
            break;
          case 'gender':
            comparison = a.gender!.compareTo(b.gender!);
            break;
        }

        // Apply ascending or descending order
        return order == 'asc' ? comparison : -comparison;
      });
    });
  }

  String selectedSortBy = 'name';
  String selectedOrder = 'asc';

  // void _openFilterDialog() async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return AlertDialog(
  //             title: Text('Filter & Sort Users', style: GoogleFonts.poppins(fontSize: 16)),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Sorting by column
  //                 DropdownButton<String>(
  //                   value: selectedSortBy,  // Use the selectedSortBy value
  //                   items: [
  //                     DropdownMenuItem(
  //                       value: 'name',
  //                       child: Text('Name', style: GoogleFonts.poppins(fontSize: 14)),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'age',
  //                       child: Text('Age', style: GoogleFonts.poppins(fontSize: 14)),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'gender',
  //                       child: Text('Gender', style: GoogleFonts.poppins(fontSize: 14)),
  //                     ),
  //                   ],
  //                   onChanged: (value) {
  //                     setState(() {
  //                       selectedSortBy = value!;
  //                     });
  //                   },
  //                 ),
  //                 DropdownButton<String>(
  //                   value: selectedOrder,  // Use the selectedOrder value
  //                   items: [
  //                     DropdownMenuItem(
  //                       value: 'asc',
  //                       child: Text('Ascending', style: GoogleFonts.poppins(fontSize: 14)),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'desc',
  //                       child: Text('Descending', style: GoogleFonts.poppins(fontSize: 14)),
  //                     ),
  //                   ],
  //                   onChanged: (value) {
  //                     setState(() {
  //                       selectedOrder = value!;
  //                     });
  //                   },
  //                 ),
  //               ],
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();  // Close the dialog
  //                 },
  //                 child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   // Apply filter and sorting
  //                   _applyFilterSort(selectedSortBy, selectedOrder);
  //                   Navigator.of(context).pop();  // Close the dialog
  //                 },
  //                 child: Text('Apply', style: GoogleFonts.poppins(fontSize: 14)),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

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
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sorting by column with icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sort by:',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      DropdownButton<String>(
                        value: selectedSortBy,
                        items: [
                          DropdownMenuItem(
                            value: 'name',
                            child: Row(
                              children: [
                                Icon(Icons.person, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Name', style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'age',
                            child: Row(
                              children: [
                                Icon(Icons.cake_rounded, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Age', style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'gender',
                            child: Row(
                              children: [
                                Icon(Icons.people_alt_rounded, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Gender', style: GoogleFonts.poppins(fontSize: 14)),
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
                  SizedBox(height: 16),
                  // Sorting order with icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order:',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      DropdownButton<String>(
                        value: selectedOrder,
                        items: [
                          DropdownMenuItem(
                            value: 'asc',
                            child: Row(
                              children: [
                                Icon(Icons.arrow_upward, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Ascending', style: GoogleFonts.poppins(fontSize: 14)),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'desc',
                            child: Row(
                              children: [
                                Icon(Icons.arrow_downward, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Descending', style: GoogleFonts.poppins(fontSize: 14)),
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
                    Navigator.of(context).pop();  // Close the dialog
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red, // Color of the button text
                  ),
                  child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filter and sorting
                    _applyFilterSort(selectedSortBy, selectedOrder);
                    Navigator.of(context).pop();  // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Apply', style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User List',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
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
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: _openFilterDialog,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.red.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: _filterUsers,
                    decoration: InputDecoration(
                      labelText: 'Search User',
                      labelStyle: GoogleFonts.poppins(color: Colors.redAccent),
                      prefixIcon: Icon(Icons.search, color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  User user = filteredUsers[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      // title: Text(
                      //   user.name!,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                      // ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // CircleAvatar(
                              //   radius: 20,
                              //   backgroundColor: Colors.grey[300],
                              //   child: ClipOval(
                              //     child: Image.asset(
                              //       'assets/images/avatar.png',
                              //       fit: BoxFit.cover,
                              //       height: 100,
                              //       width: 100,
                              //     ),
                              //   ),
                              // ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                child: ClipOval(
                                  child: Image.asset(
                                    user.gender == 'Male'
                                        ? 'assets/images/male_avatar.png'
                                        : 'assets/images/female_avatar3.png',
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                user.name!,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on, color: Colors.blue),
                              SizedBox(width: 8),
                              Text("${user.city}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.phone, color: Colors.green),
                              SizedBox(width: 8),
                              Text("${user.phone}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.email, color: Colors.orange),
                              SizedBox(width: 8),
                              Text("${user.email}", overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.cake, color: Colors.purple),
                              SizedBox(width: 8),
                              Text("Age: ${user.age}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  user.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: user.isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () => _toggleFavorite(user),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editUser(user),
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.delete, color: Colors.red),
                              //   onPressed: () => _confirmDelete(index),
                              // ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(user), // Pass the user object instead of index
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
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
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addNewUser,
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.redAccent[400],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Wait for the result from AddUserPage
          User? newUser = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserPage(),
            ),
          );

          if (newUser != null) {
            setState(() {
              userList.insert(0, newUser);
              filteredUsers = List.from(userList);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent[400],
      ),
    );
  }
}
