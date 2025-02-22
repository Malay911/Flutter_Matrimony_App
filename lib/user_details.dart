import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/database_helper.dart';
import 'user_class.dart';
import 'edit_user.dart';
import 'package:intl/intl.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  final Function(User) onUpdate;
  final Function(User) onDelete;

  UserDetailsPage({
    required this.user,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late User currentUser;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    isFavorite = currentUser.isFavorite;
  }

  void _updateUser(User updatedUser) {
    setState(() {
      currentUser = updatedUser;
    });
    widget.onUpdate(updatedUser);
  }

  // void _toggleFavorite() {
  //   setState(() {
  //     currentUser.isFavorite = !currentUser.isFavorite;
  //   });
  //   widget.onUpdate(currentUser);
  // }

  // void _toggleFavorite() {
  //   if (currentUser.isFavorite) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Confirm Unfavorite', style: GoogleFonts.poppins(fontSize: 16)),
  //           content: Text('Are you sure you want to remove this user from your favorites?', style: GoogleFonts.poppins(fontSize: 14)),
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
  //                   currentUser.isFavorite = !currentUser.isFavorite;
  //                 });
  //                 widget.onUpdate(currentUser);
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     setState(() {
  //       currentUser.isFavorite = !currentUser.isFavorite;
  //     });
  //     widget.onUpdate(currentUser);
  //   }
  // }
  // void _toggleFavorite(User user) async {
  //   if (user.isFavorite) {
  //     bool? confirmUnfavorite = await showDialog<bool>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Confirm Unfavorite', style: GoogleFonts.poppins(fontSize: 16)),
  //           content: Text('Are you sure you want to unfavorite this user?', style: GoogleFonts.poppins(fontSize: 14)),
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
  //               child: Text('Unfavorite', style: GoogleFonts.poppins(fontSize: 14)),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //
  //     if (confirmUnfavorite == true) {
  //       DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //       bool newFavoriteStatus = !user.isFavorite;
  //       setState(() {
  //         user.isFavorite = newFavoriteStatus;
  //       });
  //       await databaseHelper.updateUser(user);
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
  // void _toggleFavorite() async {
  //   setState(() {
  //     currentUser.isFavorite = !currentUser.isFavorite;
  //   });
  //
  //   await DatabaseHelper.instance.updateUser(currentUser);
  //
  //   widget.onUpdate(currentUser);
  // }
  void _toggleFavorite() async {
    if (currentUser.isFavorite) {
      // Only ask for confirmation when the user is unfavoriting (i.e., when currentUser.isFavorite is true)
      bool confirmUnfavorite = await _showUnfavoriteConfirmationDialog();
      if (!confirmUnfavorite) {
        return; // If the user doesn't confirm, don't change the favorite status
      }
    }

    // Proceed with toggling the favorite status
    setState(() {
      currentUser.isFavorite = !currentUser.isFavorite;
    });

    await DatabaseHelper.instance.updateUser(currentUser);

    widget.onUpdate(currentUser);
  }

  Future<bool> _showUnfavoriteConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unfavorite User'),
          content: Text('Are you sure you want to unfavorite this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Ensure a bool value is returned
  }

  // int _calculateAge(String dob) {
  //   DateTime birthDate = DateFormat("yyyy-MM-dd").parse(dob);
  //   DateTime today = DateTime.now();
  //   int age = today.year - birthDate.year;
  //
  //   if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
  //     age--;
  //   }
  //   return age;
  // }
  int _calculateAge(String dob) {
    try {
      // Ensure dob is not empty or null
      if (dob.isEmpty) {
        print("Error: DOB is empty");
        return 0;
      }

      // Debugging print
      print("Parsing DOB: $dob");

      // Parse the date in 'dd-MM-yyyy' format
      DateTime birthDate = DateFormat("dd-MM-yyyy").parse(dob);
      DateTime today = DateTime.now();

      int age = today.year - birthDate.year;

      // Adjust if birthday hasn't occurred yet this year
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      // Debugging print
      print("Calculated Age: $age");

      return age;
    } catch (e) {
      print("Error parsing DOB: $dob - ${e.toString()}");
      return 0; // Return 0 if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(currentUser.name!, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
        title: Text('User Details', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.white)),
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
          // IconButton(
          //   icon: Icon(
          //     currentUser.isFavorite ? Icons.favorite : Icons.favorite_border,
          //     color: currentUser.isFavorite ? Colors.red : Colors.white,
          //   ),
          //   onPressed: () => _toggleFavorite(currentUser),
          // )
          IconButton(
            icon: Icon(
              currentUser.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: currentUser.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Positioned.fill(
      //       child: Container(
      //           decoration: BoxDecoration(
      //             gradient: LinearGradient(
      //               colors: [
      //                 Colors.white,
      //                 Colors.red.shade300,
      //               ],
      //               begin: Alignment.topCenter,
      //               end: Alignment.bottomCenter,
      //             ),
      //           ),)
      //     ),
      //     // Positioned.fill(
      //     //   child: BackdropFilter(
      //     //     filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      //     //     child: Container(
      //     //       color: Colors.black.withOpacity(0.3),
      //     //     ),
      //     //   ),
      //     // ),
      //     SingleChildScrollView(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Container(
      //           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      //           padding: const EdgeInsets.all(16.0),
      //           decoration: BoxDecoration(
      //             color: Colors.white.withOpacity(0.7),
      //             borderRadius: BorderRadius.circular(15),
      //             boxShadow: const [
      //               BoxShadow(
      //                 color: Colors.black26,
      //                 blurRadius: 10,
      //                 spreadRadius: 2,
      //               ),
      //             ],
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               _buildSectionTitle("About"),
      //               _buildDetailRow("Name", currentUser.name!),
      //               _buildDetailRow("Gender", currentUser.gender ?? 'Not specified'),
      //               _buildDetailRow("Date of Birth", currentUser.dob ?? 'Not specified'),
      //               _buildDetailRow("Age", currentUser.dob != null ? _calculateAge(currentUser.dob!).toString() : 'Not specified'),
      //               _buildDetailRow("Marital Status", currentUser.maritalStatus ?? 'Not specified'),
      //               _buildSectionTitle("Religious Background"),
      //               _buildDetailRow("Country", currentUser.country ?? 'Not specified'),
      //               _buildDetailRow("State", currentUser.state ?? 'Not specified'),
      //               _buildDetailRow("City", currentUser.city ?? 'Not specified'),
      //               _buildDetailRow("Religion", currentUser.religion ?? 'Not specified'),
      //               _buildDetailRow("Caste", currentUser.caste ?? 'Not specified'),
      //               _buildDetailRow("Sub Caste", currentUser.subCaste ?? 'Not specified'),
      //               _buildSectionTitle("Professional Details"),
      //               _buildDetailRow("Higher Education", currentUser.education ?? 'Not specified'),
      //               _buildDetailRow("Occupation", currentUser.occupation ?? 'Not specified'),
      //               _buildSectionTitle("Contact Details"),
      //               _buildDetailRow("Email", currentUser.email ?? 'Not specified'),
      //               _buildDetailRow("Phone", currentUser.phone ?? 'Not specified'),
      //               SizedBox(height: 32),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   // Edit Button
      //                   SizedBox(
      //                     width: 125,
      //                     child: ElevatedButton.icon(
      //                       onPressed: () async {
      //                         User? updatedUser = await Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => EditUserPage(user: currentUser),
      //                           ),
      //                         );
      //                         if (updatedUser != null) {
      //                           _updateUser(updatedUser);
      //                         }
      //                       },
      //                       icon: Icon(Icons.edit, color: Colors.white),
      //                       label: Text("Edit", style: GoogleFonts.poppins()),
      //                       style: ElevatedButton.styleFrom(
      //                         backgroundColor: Colors.blueAccent,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(12.0),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   // Delete Button
      //                   SizedBox(
      //                     width: 125,
      //                     child: ElevatedButton.icon(
      //                       onPressed: () {
      //                         showDialog(
      //                           context: context,
      //                           builder: (BuildContext context) {
      //                             return AlertDialog(
      //                               title: Text('Delete User', style: GoogleFonts.poppins()),
      //                               content: Text('Are you sure you want to delete this user?', style: GoogleFonts.poppins()),
      //                               actions: [
      //                                 TextButton(
      //                                   onPressed: () {
      //                                     Navigator.pop(context);
      //                                   },
      //                                   child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
      //                                 ),
      //                                 TextButton(
      //                                   onPressed: () {
      //                                     widget.onDelete(currentUser);
      //                                     Navigator.pop(context); // Close the dialog
      //                                     Navigator.pop(context); // Navigate back to the User List page
      //                                   },
      //                                   child: Text('Delete', style: GoogleFonts.poppins(color: Colors.redAccent)),
      //                                 ),
      //                               ],
      //                             );
      //                           },
      //                         );
      //                       },
      //                       icon: Icon(Icons.delete, color: Colors.white),
      //                       label: Text("Delete", style: GoogleFonts.poppins()),
      //                       style: ElevatedButton.styleFrom(
      //                         backgroundColor: Colors.redAccent,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(12.0),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   // Back to List Button
      //                   // ElevatedButton.icon(
      //                   //   onPressed: () => Navigator.pop(context),
      //                   //   icon: Icon(Icons.arrow_back, color: Colors.white),
      //                   //   label: Text("Back", style: GoogleFonts.poppins()),
      //                   //   style: ElevatedButton.styleFrom(
      //                   //     backgroundColor: Colors.green,
      //                   //     shape: RoundedRectangleBorder(
      //                   //       borderRadius: BorderRadius.circular(12.0),
      //                   //     ),
      //                   //   ),
      //                   // ),
      //                 ],
      //               ),
      //             ],
      //           )
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.red.shade300,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 50,
                        //   backgroundColor: Colors.grey.shade400,
                        //   child: ClipOval(
                        //     child: Image.asset(
                        //       'assets/images/avatar.png',
                        //       fit: BoxFit.cover,
                        //       height: 100,
                        //       width: 100,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: ClipOval(
                              child: Image.asset(
                                currentUser.gender == 'Male'
                                    ? 'assets/images/male_avatar.png'
                                    : 'assets/images/female_avatar3.png',
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          currentUser.name!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            letterSpacing: 1.0,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSectionTitle("About"),
                  _buildDetailRow("Name", currentUser.name!),
                  _buildDetailRow("Gender", currentUser.gender ?? 'Not specified'),
                  _buildDetailRow("Date of Birth", currentUser.dob ?? 'Not specified'),
                  _buildDetailRow("Age", currentUser.dob != null ? _calculateAge(currentUser.dob!).toString() : 'Not specified'),
                  _buildDetailRow("Marital Status", currentUser.maritalStatus ?? 'Not specified'),
                  _buildSectionTitle("Religious Background"),
                  _buildDetailRow("Country", currentUser.country ?? 'Not specified'),
                  _buildDetailRow("State", currentUser.state ?? 'Not specified'),
                  _buildDetailRow("City", currentUser.city ?? 'Not specified'),
                  _buildDetailRow("Religion", currentUser.religion ?? 'Not specified'),
                  _buildDetailRow("Caste", currentUser.caste ?? 'Not specified'),
                  _buildDetailRow("Sub Caste", currentUser.subCaste ?? 'Not specified'),
                  _buildSectionTitle("Professional Details"),
                  _buildDetailRow("Higher Education", currentUser.education ?? 'Not specified'),
                  _buildDetailRow("Occupation", currentUser.occupation ?? 'Not specified'),
                  _buildSectionTitle("Contact Details"),
                  _buildDetailRow("Email", currentUser.email ?? 'Not specified'),
                  _buildDetailRow("Phone", currentUser.phone ?? 'Not specified'),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Edit Button
                      SizedBox(
                        width: 125,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            User? updatedUser = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUserPage(user: currentUser),
                              ),
                            );
                            if (updatedUser != null) {
                              _updateUser(updatedUser);
                            }
                          },
                          icon: Icon(Icons.edit, color: Colors.white),
                          label: Text("Edit", style: GoogleFonts.poppins(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      // Delete Button
                      SizedBox(
                        width: 125,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete User', style: GoogleFonts.poppins()),
                                  content: Text('Are you sure you want to delete this user?', style: GoogleFonts.poppins()),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        widget.onDelete(currentUser);
                                        Navigator.pop(context); // Close the dialog
                                        Navigator.pop(context); // Navigate back to the User List page
                                      },
                                      child: Text('Delete', style: GoogleFonts.poppins(color: Colors.redAccent[400])),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                          label: Text("Delete", style: GoogleFonts.poppins(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$title",
              // overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              // overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}