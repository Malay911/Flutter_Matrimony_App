import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/api_service.dart';
import 'package:matrimony_app/database_helper.dart';
import 'user_class.dart';
import 'edit_user.dart';
import 'package:intl/intl.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  final Function(User) onUpdate;
  final Function(User) onDelete;

  const UserDetailsPage({
    super.key,
    required this.user,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final ApiService _apiService = ApiService();
  late User currentUser;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    isFavorite = currentUser.isFavorite;
  }

  // void _updateUser(User updatedUser) {
  //   setState(() {
  //     currentUser = updatedUser;
  //   });
  //   widget.onUpdate(updatedUser);
  // }
  void _updateUser(User updatedUser) async {
    try {
      // Update in API
      await _apiService.updateUser(updatedUser.toJson());

      setState(() {
        currentUser = updatedUser;
      });

      widget.onUpdate(updatedUser);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Profile updated successfully'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _toggleFavorite() async {
  //   if (currentUser.isFavorite) {
  //     // Only ask for confirmation when the user is unfavoriting (i.e., when currentUser.isFavorite is true)
  //     bool confirmUnfavorite = await _showUnfavoriteConfirmationDialog();
  //     if (!confirmUnfavorite) {
  //       return; // If the user doesn't confirm, don't change the favorite status
  //     }
  //   }

  //   // Proceed with toggling the favorite status
  //   setState(() {
  //     currentUser.isFavorite = !currentUser.isFavorite;
  //   });

  //   await DatabaseHelper.instance.updateUser(currentUser);

  //   widget.onUpdate(currentUser);
  // }
  void _toggleFavorite() async {
    if (currentUser.isFavorite) {
      bool confirmUnfavorite = await _showUnfavoriteConfirmationDialog();
      if (!confirmUnfavorite) {
        return;
      }
    }
    try {
      setState(() {
        currentUser.isFavorite = !currentUser.isFavorite;
      });
      await _apiService.updateUser(currentUser.toJson());
      widget.onUpdate(currentUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentUser.isFavorite
              ? 'Added to favorites'
              : 'Removed from favorites'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        currentUser.isFavorite = !currentUser.isFavorite;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update favorite status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> _showUnfavoriteConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unfavorite User'),
          content: const Text('Are you sure you want to unfavorite this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  int _calculateAge(String dob) {
    try {
      if (dob.isEmpty) {
        print("Error: DOB is empty");
        return 0;
      }

      print("Parsing DOB: $dob");

      DateTime birthDate = DateFormat("dd-MM-yyyy").parse(dob);
      DateTime today = DateTime.now();

      int age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      print("Calculated Age: $age");

      return age;
    } catch (e) {
      print("Error parsing DOB: $dob - ${e.toString()}");
      return 0;
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 5,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              height: 1,
              color: Colors.redAccent.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile Details',
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
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                currentUser.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: currentUser.isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: _toggleFavorite,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red.shade400,
              Colors.redAccent.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.redAccent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
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
                      SizedBox(height: 16),
                      Text(
                        currentUser.name!,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${currentUser.occupation}, ${_calculateAge(currentUser.dob!)} years",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("About"),
                      _buildDetailRow(
                          "Gender", currentUser.gender ?? 'Not specified'),
                      _buildDetailRow(
                          "Date of Birth", currentUser.dob ?? 'Not specified'),
                      _buildDetailRow("Marital Status",
                          currentUser.maritalStatus ?? 'Not specified'),

                      _buildSectionTitle("Location"),
                      _buildDetailRow(
                          "Country", currentUser.country ?? 'Not specified'),
                      _buildDetailRow(
                          "State", currentUser.state ?? 'Not specified'),
                      _buildDetailRow(
                          "City", currentUser.city ?? 'Not specified'),

                      _buildSectionTitle("Religious Background"),
                      _buildDetailRow(
                          "Religion", currentUser.religion ?? 'Not specified'),
                      _buildDetailRow(
                          "Caste", currentUser.caste ?? 'Not specified'),
                      _buildDetailRow(
                          "Sub Caste", currentUser.subCaste ?? 'Not specified'),

                      _buildSectionTitle("Professional Details"),
                      _buildDetailRow("Education",
                          currentUser.education ?? 'Not specified'),
                      _buildDetailRow("Occupation",
                          currentUser.occupation ?? 'Not specified'),

                      _buildSectionTitle("Contact Details"),
                      _buildDetailRow(
                          "Email", currentUser.email ?? 'Not specified'),
                      _buildDetailRow(
                          "Phone", currentUser.phone ?? 'Not specified'),

                      SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            "Edit",
                            Icons.edit_rounded,
                            Colors.blue,
                            () async {
                              User? updatedUser = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserPage(user: currentUser),
                                ),
                              );
                              if (updatedUser != null) {
                                _updateUser(updatedUser);
                              }
                            },
                          ),
                          _buildActionButton(
                            "Delete",
                            Icons.delete_rounded,
                            Colors.red,
                            () => _showDeleteConfirmation(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      width: 140,
      height: 45,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 5,
          shadowColor: color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Delete Profile',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this profile? This action cannot be undone.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onDelete(currentUser);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Delete',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
