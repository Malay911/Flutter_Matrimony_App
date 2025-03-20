import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_user.dart';
import 'login_screen.dart';
import 'user_class.dart';
import 'user_details.dart';
// import 'user_data.dart';
import 'database_helper.dart';

class FavoriteUsersPage extends StatefulWidget {
  const FavoriteUsersPage({super.key});

  @override
  _FavoriteUsersPageState createState() => _FavoriteUsersPageState();
}

class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  List<User> allFavoriteUsers = [];
  List<User> filteredFavoriteUsers = [];
  String userName = 'Guest';
  String userEmail = 'guest@example.com';

  @override
  void initState() {
    super.initState();
    _loadFavoriteUsers();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
    });
  }

  // Load favorite users from the database
  // void _loadFavoriteUsers() async {
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //   List<User> users = await databaseHelper.fetchUsers();
  //   setState(() {
  //     allFavoriteUsers = users.where((user) => user.isFavorite).toList();
  //     filteredFavoriteUsers = List.from(allFavoriteUsers);
  //   });
  // }
  // void _loadFavoriteUsers() async {
  //   try {
  //     List<User> apiUsers = await _apiService.fetchUsers();
  //     setState(() {
  //       allFavoriteUsers = apiUsers.where((user) => user.isFavorite).toList();
  //       filteredFavoriteUsers = List.from(allFavoriteUsers);
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error loading favorite users: $e')),
  //     );
  //   }
  // }
  void _loadFavoriteUsers() async {
    try {
      setState(() {
        _isLoading = true; // Start loading
      });

      List<User> apiUsers = await _apiService.fetchUsers();

      if (mounted) {
        setState(() {
          allFavoriteUsers = apiUsers.where((user) => user.isFavorite).toList();
          filteredFavoriteUsers = List.from(allFavoriteUsers);
          _isLoading = false; // End loading
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false; // End loading even on error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading favorite users: $e')),
        );
      }
    }
  }

  // Toggle the favorite status of a user
  // void _toggleFavorite(User user) async {
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //   user.isFavorite = !user.isFavorite; // Toggle the favorite status
  //
  //   await databaseHelper.updateUser(user); // Update the user in the database
  //   _loadFavoriteUsers(); // Reload favorite users
  // }
  // void _toggleFavorite(User user) async {
  //   // If the user is already unfavorited, show a confirmation dialog
  //   if (user.isFavorite) {
  //     bool? confirmUnfavorite = await _showUnfavoriteDialog();
  //     if (confirmUnfavorite == true) {
  //       // User confirmed unfavorite, toggle the status
  //       DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //       user.isFavorite = !user.isFavorite; // Toggle the favorite status

  //       await databaseHelper
  //           .updateUser(user); // Update the user in the database
  //       _loadFavoriteUsers(); // Reload favorite users
  //     }
  //   } else {
  //     // If the user is not a favorite, directly toggle
  //     DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //     user.isFavorite = !user.isFavorite; // Toggle the favorite status

  //     await databaseHelper.updateUser(user); // Update the user in the database
  //     _loadFavoriteUsers(); // Reload favorite users
  //   }
  // }
  // void _toggleFavorite(User user) async {
  //   if (user.isFavorite) {
  //     bool? confirmUnfavorite = await _showUnfavoriteDialog();
  //     if (confirmUnfavorite == true) {
  //       try {
  //         // Update favorite status
  //         user.isFavorite = false;

  //         // Update in API
  //         await _apiService.updateUser(user.toJson());

  //         // Refresh the list
  //         _loadFavoriteUsers();

  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Removed from favorites')),
  //         );
  //       } catch (e) {
  //         // Revert if failed
  //         user.isFavorite = true;
  //         setState(() {});
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Failed to update favorite status: $e')),
  //         );
  //       }
  //     }
  //   } else {
  //     try {
  //       // Update favorite status
  //       user.isFavorite = true;

  //       // Update in API
  //       await _apiService.updateUser(user.toJson());

  //       // Refresh the list
  //       _loadFavoriteUsers();

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Added to favorites')),
  //       );
  //     } catch (e) {
  //       // Revert if failed
  //       user.isFavorite = false;
  //       setState(() {});
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to update favorite status: $e')),
  //       );
  //     }
  //   }
  // }
  void _toggleFavorite(User user) async {
    if (user.isFavorite) {
      bool? confirmUnfavorite = await _showUnfavoriteDialog();
      if (confirmUnfavorite == true) {
        try {
          // Update favorite status locally first
          setState(() {
            user.isFavorite = false;
            // Remove from filtered and all favorites lists
            filteredFavoriteUsers.remove(user);
            allFavoriteUsers.remove(user);
          });

          // Try to update in API
          try {
            await _apiService.updateUser(user.toJson());
          } catch (e) {
            print(
                'API Update failed: $e'); // Log the error but don't show to user
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Removed from favorites')),
          );
        } catch (e) {
          // Revert if failed
          setState(() {
            user.isFavorite = true;
            if (!allFavoriteUsers.contains(user)) {
              allFavoriteUsers.add(user);
              filteredFavoriteUsers = List.from(allFavoriteUsers);
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update favorite status')),
          );
        }
      }
    } else {
      try {
        // Update favorite status locally first
        setState(() {
          user.isFavorite = true;
          if (!allFavoriteUsers.contains(user)) {
            allFavoriteUsers.add(user);
            filteredFavoriteUsers = List.from(allFavoriteUsers);
          }
        });

        // Try to update in API
        try {
          await _apiService.updateUser(user.toJson());
        } catch (e) {
          print(
              'API Update failed: $e'); // Log the error but don't show to user
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added to favorites')),
        );
      } catch (e) {
        // Revert if failed
        setState(() {
          user.isFavorite = false;
          allFavoriteUsers.remove(user);
          filteredFavoriteUsers = List.from(allFavoriteUsers);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favorite status')),
        );
      }
    }
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

  Future<bool?> _showUnfavoriteDialog() {
    return showDialog<bool>(
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
                Navigator.of(context)
                    .pop(false); // User cancels, do not unfavorite
              },
              child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // User confirms, proceed with unfavoriting
              },
              child:
                  Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(User user) {
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
                // await databaseHelper.deleteUser(user.id!);
                await _apiService.deleteUser(user.id!);
                setState(() {
                  allFavoriteUsers.remove(user);
                  filteredFavoriteUsers.remove(user);
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
  // void _searchUsers(String query) async {
  //   // Fetch the users from the database based on the search query
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //   List<User> users = await databaseHelper.fetchUsers();
  //   setState(() {
  //     if (query.isEmpty) {
  //       filteredFavoriteUsers = users.where((user) => user.isFavorite).toList();
  //     } else {
  //       filteredFavoriteUsers = users
  //           .where((user) =>
  //               user.isFavorite &&
  //               (user.name!.toLowerCase().contains(query.toLowerCase()) ||
  //                   user.city!.toLowerCase().contains(query.toLowerCase()) ||
  //                   user.email!.toLowerCase().contains(query.toLowerCase()) ||
  //                   user.phone!.toLowerCase().contains(query.toLowerCase()) ||
  //                   user.age.toString().contains(query)))
  //           .toList();
  //     }
  //   });
  // }
  void _searchUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFavoriteUsers = List.from(allFavoriteUsers);
      } else {
        filteredFavoriteUsers = allFavoriteUsers
            .where((user) =>
                user.name!.toLowerCase().contains(query.toLowerCase()) ||
                user.city!.toLowerCase().contains(query.toLowerCase()) ||
                user.email!.toLowerCase().contains(query.toLowerCase()) ||
                user.phone!.toLowerCase().contains(query.toLowerCase()) ||
                user.age.toString().contains(query))
            .toList();
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
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      // await databaseHelper.updateUser(updatedUser);
      await _apiService.updateUser(updatedUser.toJson());
      _loadFavoriteUsers();
    }
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
                      Container(width: 1, height: 24, color: Colors.grey[300]),
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

  void _navigateToDetails(User user) {
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
            'Favorite Profiles',
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
                    icon: Icons.list_rounded,
                    title: "Profiles",
                    onTap: () => Navigator.pushNamed(context, '/userList'),
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
                    onChanged: _searchUsers,
                    decoration: InputDecoration(
                      hintText: 'Search favorites...',
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
              //   child: filteredFavoriteUsers.isEmpty
              //       ? Center(
              //           child: Text(
              //             'No favorite profiles yet',
              //             style: GoogleFonts.poppins(
              //               fontSize: 16,
              //               color: Colors.grey[600],
              //             ),
              //           ),
              //         )
              //       : ListView.builder(
              //           padding: EdgeInsets.only(bottom: 20),
              //           itemCount: filteredFavoriteUsers.length,
              //           itemBuilder: (context, index) =>
              //               _buildUserCard(filteredFavoriteUsers[index]),
              //         ),
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
                              'Loading favorite profiles...',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : filteredFavoriteUsers.isEmpty
                        ? Center(
                            child: Text(
                              'No favorite profiles yet',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 20),
                            itemCount: filteredFavoriteUsers.length,
                            itemBuilder: (context, index) =>
                                _buildUserCard(filteredFavoriteUsers[index]),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
