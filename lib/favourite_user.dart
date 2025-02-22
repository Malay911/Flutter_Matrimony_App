// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'edit_user.dart';
// import 'user_class.dart';
// import 'user_details.dart';
// import 'user_data.dart';
//
// class FavoriteUsersPage extends StatefulWidget {
//   @override
//   _FavoriteUsersPageState createState() => _FavoriteUsersPageState();
// }
//
// class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
//   TextEditingController searchController = TextEditingController();
//   List<User> allFavoriteUsers = [];
//   List<User> filteredFavoriteUsers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _filterFavoriteUsers();
//   }
//
//   void _filterFavoriteUsers() {
//     setState(() {
//       allFavoriteUsers = userList.where((user) => user.isFavorite).toList();
//       filteredFavoriteUsers = List.from(allFavoriteUsers);
//     });
//   }
//
//   // void _toggleFavorite(User user) {
//   //   setState(() {
//   //     user.isFavorite = !user.isFavorite;
//   //     _filterFavoriteUsers();
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
//                     user.isFavorite = false;
//                     _filterFavoriteUsers();
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
//         user.isFavorite = true;
//         _filterFavoriteUsers();
//       });
//     }
//   }
//
//   void _confirmDelete(int index) {
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
//               onPressed: () {
//                 setState(() {
//                   userList.removeAt(index);
//                   _filterFavoriteUsers();
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
//           'Favourite Users',
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
//
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade50, Colors.redAccent.shade100],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               // child: TextField(
//               //   controller: searchController,
//               //   onChanged: (query) {
//               //     setState(() {
//               //       if (query.isEmpty) {
//               //         filteredFavoriteUsers = List.from(allFavoriteUsers);
//               //       } else {
//               //         filteredFavoriteUsers = allFavoriteUsers
//               //             .where((user) =>
//               //         user.name!.toLowerCase().contains(query.toLowerCase()) ||
//               //             user.city!.toLowerCase().contains(query.toLowerCase()) ||
//               //             user.email!.toLowerCase().contains(query.toLowerCase()) ||
//               //             user.phone!.toLowerCase().contains(query.toLowerCase()) ||
//               //             user.age.toString().contains(query))
//               //             .toList();
//               //       }
//               //     });
//               //   },
//               //   decoration: InputDecoration(
//               //     labelText: 'Search Favorite User',
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
//                     onChanged: (query) {
//                       setState(() {
//                         if (query.isEmpty) {
//                           filteredFavoriteUsers = List.from(allFavoriteUsers);
//                         } else {
//                           filteredFavoriteUsers = allFavoriteUsers
//                               .where((user) =>
//                                   user.name!
//                                       .toLowerCase()
//                                       .contains(query.toLowerCase()) ||
//                                   user.city!
//                                       .toLowerCase()
//                                       .contains(query.toLowerCase()) ||
//                                   user.email!
//                                       .toLowerCase()
//                                       .contains(query.toLowerCase()) ||
//                                   user.phone!
//                                       .toLowerCase()
//                                       .contains(query.toLowerCase()) ||
//                                   user.age.toString().contains(query))
//                               .toList();
//                         }
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Search Favourite User',
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
//                 itemCount: filteredFavoriteUsers.length,
//                 itemBuilder: (context, index) {
//                   User user = filteredFavoriteUsers[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 5,
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(15),
//                       title: Text(user.name!,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.poppins(
//                               fontSize: 18, fontWeight: FontWeight.w500)),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("State: ${user.city}",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14, color: Colors.black54)),
//                           Text("Phone: ${user.phone}",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14, color: Colors.black54)),
//                           Text("Email: ${user.email}",
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14, color: Colors.black54)),
//                           Text("DOB: ${user.dob}",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14, color: Colors.black54)),
//                           Text("Age: ${user.age}",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14, color: Colors.black54)),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               user.isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: user.isFavorite ? Colors.red : Colors.grey,
//                             ),
//                             onPressed: () => _toggleFavorite(user),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () async {
//                               User? updatedUser = await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       EditUserPage(user: user),
//                                 ),
//                               );
//                               if (updatedUser != null) {
//                                 setState(() {
//                                   userList[userList.indexOf(user)] =
//                                       updatedUser;
//                                   _filterFavoriteUsers();
//                                 });
//                               }
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () =>
//                                 _confirmDelete(userList.indexOf(user)),
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
//                                   userList[userList.indexOf(user)] =
//                                       updatedUser;
//                                   _filterFavoriteUsers();
//                                 });
//                               },
//                               onDelete: (deletedUser) {
//                                 setState(() {
//                                   userList.remove(deletedUser);
//                                   _filterFavoriteUsers();
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
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_user.dart';
import 'user_class.dart';
import 'user_details.dart';
// import 'user_data.dart';
import 'database_helper.dart';

class FavoriteUsersPage extends StatefulWidget {
  @override
  _FavoriteUsersPageState createState() => _FavoriteUsersPageState();
}

class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
  TextEditingController searchController = TextEditingController();
  List<User> allFavoriteUsers = [];
  List<User> filteredFavoriteUsers = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteUsers();
  }

  // Load favorite users from the database
  void _loadFavoriteUsers() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List<User> users = await databaseHelper.fetchUsers();
    setState(() {
      allFavoriteUsers = users.where((user) => user.isFavorite).toList();
      filteredFavoriteUsers = List.from(allFavoriteUsers);
    });
  }

  // Toggle the favorite status of a user
  // void _toggleFavorite(User user) async {
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //   user.isFavorite = !user.isFavorite; // Toggle the favorite status
  //
  //   await databaseHelper.updateUser(user); // Update the user in the database
  //   _loadFavoriteUsers(); // Reload favorite users
  // }
  void _toggleFavorite(User user) async {
    // If the user is already unfavorited, show a confirmation dialog
    if (user.isFavorite) {
      bool? confirmUnfavorite = await _showUnfavoriteDialog();
      if (confirmUnfavorite == true) {
        // User confirmed unfavorite, toggle the status
        DatabaseHelper databaseHelper = DatabaseHelper.instance;
        user.isFavorite = !user.isFavorite; // Toggle the favorite status

        await databaseHelper.updateUser(user); // Update the user in the database
        _loadFavoriteUsers(); // Reload favorite users
      }
    } else {
      // If the user is not a favorite, directly toggle
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      user.isFavorite = !user.isFavorite; // Toggle the favorite status

      await databaseHelper.updateUser(user); // Update the user in the database
      _loadFavoriteUsers(); // Reload favorite users
    }
  }

  Future<bool?> _showUnfavoriteDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Unfavorite', style: GoogleFonts.poppins(fontSize: 16)),
          content: Text('Are you sure you want to unfavorite this user?', style: GoogleFonts.poppins(fontSize: 14)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User cancels, do not unfavorite
              },
              child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms, proceed with unfavoriting
              },
              child: Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(int index) {
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
                await databaseHelper.deleteUser(filteredFavoriteUsers[index].id!); // Delete the user
                setState(() {
                  filteredFavoriteUsers.removeAt(index); // Update the UI
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

  // Search functionality
  void _searchUsers(String query) async {
    // Fetch the users from the database based on the search query
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List<User> users = await databaseHelper.fetchUsers();
    setState(() {
      if (query.isEmpty) {
        filteredFavoriteUsers = users.where((user) => user.isFavorite).toList();
      } else {
        filteredFavoriteUsers = users
            .where((user) =>
        user.isFavorite &&
            (user.name!.toLowerCase().contains(query.toLowerCase()) ||
                user.city!.toLowerCase().contains(query.toLowerCase()) ||
                user.email!.toLowerCase().contains(query.toLowerCase()) ||
                user.phone!.toLowerCase().contains(query.toLowerCase()) ||
                user.age.toString().contains(query)))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Users',
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.red.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                    onChanged: (query) {
                      _searchUsers(query);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search Favourite User',
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
                itemCount: filteredFavoriteUsers.length,
                itemBuilder: (context, index) {
                  User user = filteredFavoriteUsers[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Row(
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on, color: Colors.blue), // Icon for State
                              SizedBox(width: 8),
                              Text("${user.city}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.phone, color: Colors.green), // Icon for Phone
                              SizedBox(width: 8),
                              Text("${user.phone}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.email, color: Colors.orange), // Icon for Email
                              SizedBox(width: 8),
                              Text("${user.email}", overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.cake, color: Colors.purple), // Icon for Age (Cake emoji often represents age/birthdays)
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
                          // SizedBox(height: 10),
                          // Action buttons below Age
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
                                onPressed: () async {
                                  User? updatedUser = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditUserPage(user: user),
                                    ),
                                  );
                                  if (updatedUser != null) {
                                    setState(() {
                                      allFavoriteUsers[allFavoriteUsers.indexOf(user)] = updatedUser;
                                      _loadFavoriteUsers(); // Reload the favorite users list after update
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(filteredFavoriteUsers.indexOf(user)),
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
                                  allFavoriteUsers[allFavoriteUsers.indexOf(user)] = updatedUser;
                                  _loadFavoriteUsers();
                                });
                              },
                              onDelete: (deletedUser) {
                                setState(() {
                                  allFavoriteUsers.remove(deletedUser);
                                  _loadFavoriteUsers();
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
    );
  }
}