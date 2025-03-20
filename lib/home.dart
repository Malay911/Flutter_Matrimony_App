import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimony_app/statistics_page.dart';
import 'about_us.dart';
import 'add_user.dart';
import 'dashboard.dart';
import 'faq.dart';
import 'favourite_user.dart';
import 'user_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrimonial App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
      routes: {
        // '/': (context) => const SplashScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/userList': (context) => UserListPage(),
        '/addUser': (context) => AddUserPage(),
        // '/editUser': (context) => const PlaceholderWidget('editUser'),
        '/favourites': (context) => const FavoriteUsersPage(),
        '/aboutUs': (context) => const AboutUsScreen(),
        '/statistics': (context) => const StatisticsPage(),
        '/faq': (context) => const FAQPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Navigate to dashboard after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacementNamed(context, '/dashboard');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.red.shade400,
//               Colors.red.shade800,
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Image.asset(
//                   'assets/images/logo2.png',
//                   height: 200,
//                   width: 200,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Text(
//                 'True Companion',
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(
//                       color: Colors.black.withOpacity(0.3),
//                       offset: const Offset(2, 2),
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Tagline
//               Text(
//                 'Find Your Perfect Match',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Loading Indicator
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: const CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   strokeWidth: 3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PlaceholderWidget extends StatelessWidget {
//   final String title;
//   const PlaceholderWidget(this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(child: Text('$title Page Coming Soon!')),
//     );
//   }
// }

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _loadingController;
  bool _showLoadingIndicator = false;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Show loading indicator after initial animations
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _showLoadingIndicator = true);
      }
    });

    // Navigate to dashboard after animations
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade400,
              Colors.red.shade800,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with bounce animation
              FadeInDown(
                duration: const Duration(milliseconds: 1500),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/logo2.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // App name with fade animation
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                delay: const Duration(milliseconds: 500),
                child: Text(
                  'True Companion',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tagline with fade animation
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                delay: const Duration(milliseconds: 700),
                child: Text(
                  'Find Your Perfect Match',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Animated loading indicator
              if (_showLoadingIndicator)
                FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
