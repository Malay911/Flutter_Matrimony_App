// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:matrimony_app/dashboard.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _login() async {
//     FocusScope.of(context).unfocus();
//     setState(() {
//       _isLoading = true;
//     });
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//
//     await Future.delayed(Duration(seconds: 2));
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// Background Image with Overlay
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/img_8.png"),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.3),
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//           ),
//
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//
//                   /// App Logo
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage("assets/images/logo2.png"), // Your app logo
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//
//                   /// Title Text
//                   Text(
//                     'Welcome Back!',
//                     style: GoogleFonts.poppins(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           offset: Offset(2, 2),
//                           blurRadius: 5,
//                           color: Colors.black38,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//
//                   Text(
//                     'Login to continue',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       color: Colors.white70,
//                     ),
//                   ),
//
//                   SizedBox(height: 30),
//
//                   /// Email Input
//                   _buildTextField(
//                     controller: _emailController,
//                     hintText: "Enter your email",
//                     icon: Icons.email,
//                   ),
//
//                   SizedBox(height: 15),
//
//                   /// Password Input
//                   _buildTextField(
//                     controller: _passwordController,
//                     hintText: "Enter your password",
//                     icon: Icons.lock,
//                     obscureText: true,
//                   ),
//
//                   SizedBox(height: 30),
//
//                   /// Login Button
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     width: _isLoading ? 50 : double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : _login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         shadowColor: Colors.black45,
//                         elevation: 8,
//                       ),
//                       child: _isLoading
//                           ? CircularProgressIndicator(color: Colors.white)
//                           : Text(
//                         'Login',
//                         style: GoogleFonts.poppins(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Input Field Widget
//   Widget _buildTextField({required TextEditingController controller, required String hintText, required IconData icon, bool obscureText = false}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.white70),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.white70),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//         ),
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:matrimony_app/dashboard.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   final _formKey = GlobalKey<FormState>(); // Added FormKey to validate the form
//
//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) {
//       return; // Return if form validation fails
//     }
//
//     FocusScope.of(context).unfocus();
//     setState(() {
//       _isLoading = true;
//     });
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//
//     await Future.delayed(Duration(seconds: 2));
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// Background Image with Overlay
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/img_8.png"),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.3),
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Form(  // Wrap the entire form in a Form widget
//                 key: _formKey, // Set the Form key here
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     /// App Logo
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage("assets/images/logo2.png"), // Your app logo
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     /// Title Text
//                     Text(
//                       'Welcome Back!',
//                       style: GoogleFonts.poppins(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(2, 2),
//                             blurRadius: 5,
//                             color: Colors.black38,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10),
//
//                     Text(
//                       'Login to continue',
//                       style: GoogleFonts.poppins(
//                         fontSize: 18,
//                         color: Colors.white70,
//                       ),
//                     ),
//
//                     SizedBox(height: 30),
//
//                     _buildTextField(
//                       controller: _emailController,
//                       hintText: "Enter your email",
//                       icon: Icons.email,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         String emailPattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';
//                         RegExp regex = RegExp(emailPattern);
//                         if (!regex.hasMatch(value)) {
//                           return 'Enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     SizedBox(height: 15),
//
//                     _buildTextField(
//                       controller: _passwordController,
//                       hintText: "Enter your password",
//                       icon: Icons.lock,
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     SizedBox(height: 30),
//
//                     AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       width: _isLoading ? 50 : 150,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: _isLoading ? null : _login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.redAccent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           shadowColor: Colors.black45,
//                           elevation: 8,
//                         ),
//                         child: _isLoading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text(
//                           'Login',
//                           style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     bool obscureText = false,
//     required String? Function(String?) validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.white70),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.white70),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//           errorStyle: TextStyle(color: Colors.white),
//         ),
//         validator: validator,
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matrimony_app/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  // Future<void> _signInWithGoogle() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     // Attempt to sign in
  //     GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //
  //     if (googleUser == null) {
  //       // User canceled the sign-in
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return;
  //     }
  //
  //     // Successfully signed in
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => DashboardScreen()),
  //     );
  //   } catch (error) {
  //     // Catch and log any errors that occur
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print("Google Sign-In error: $error");
  //
  //     // Handle error appropriately here (e.g., show a dialog to the user)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Sign-in failed: $error')),
  //     );
  //   }
  // }
  // Future<void> _signInWithGoogle() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       // User canceled the sign-in
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return;
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     // Sign in to Firebase
  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     if (userCredential.user != null) {
  //       // Save login status
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setBool('isLoggedIn', true);
  //
  //       // Navigate to Dashboard
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => DashboardScreen()),
  //       );
  //     }
  //   } catch (error) {
  //     print("Google Sign-In error: $error");
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Sign-in failed: ${error.toString()}')),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    } catch (error) {
      print("Google Sign-In error: $error");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: ${error.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image with Overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img_8.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /// App Logo
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/logo2.png"),
                      ),
                    ),

                    SizedBox(height: 20),

                    /// Title Text
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 5,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      'Login to continue',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),

                    SizedBox(height: 20),

                    _buildTextField(
                      controller: _emailController,
                      hintText: "Enter your email",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        String emailPattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';
                        RegExp regex = RegExp(emailPattern);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    _buildTextField(
                      controller: _passwordController,
                      hintText: "Enter your password",
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: _isLoading ? 50 : 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Colors.black45,
                          elevation: 8,
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Google Sign-In Button
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Colors.redAccent),
                        elevation: 8,
                      ),
                      icon: Icon(Icons.account_circle, color: Colors.white),
                      label: Text(
                        'Sign in using Google',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          errorStyle: TextStyle(color: Colors.white),
        ),
        validator: validator,
      ),
    );
  }
}
