// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'database_helper.dart';
// import 'user_class.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class StatisticsPage extends StatefulWidget {
//   const StatisticsPage({super.key});
//
//   @override
//   _StatisticsPageState createState() => _StatisticsPageState();
// }
//
// class _StatisticsPageState extends State<StatisticsPage> {
//   final PageController _pageController = PageController();
//   List<User> users = [];
//   int currentPage = 0;
//   Map<String, int> genderDistribution = {'Male': 0, 'Female': 0};
//   Map<String, int> ageGroupDistribution = {
//     '18-25': 0,
//     '26-30': 0,
//     '31-35': 0,
//     '36+': 0
//   };
//   Map<String, int> cityDistribution = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _loadStatistics();
//   }
//
//   Future<void> _loadStatistics() async {
//     DatabaseHelper databaseHelper = DatabaseHelper.instance;
//     List<User> loadedUsers = await databaseHelper.fetchUsers();
//
//     Map<String, int> genderCount = {'Male': 0, 'Female': 0};
//     Map<String, int> ageCount = {'18-25': 0, '26-30': 0, '31-35': 0, '36+': 0};
//     Map<String, int> cityCount = {};
//
//     for (var user in loadedUsers) {
//       // Gender distribution
//       genderCount[user.gender ?? 'Other'] = (genderCount[user.gender] ?? 0) + 1;
//
//       // Age group distribution
//       if (user.age <= 25) {
//         ageCount['18-25'] = ageCount['18-25']! + 1;
//       } else if (user.age <= 30) {
//         ageCount['26-30'] = ageCount['26-30']! + 1;
//       } else if (user.age <= 35) {
//         ageCount['31-35'] = ageCount['31-35']! + 1;
//       } else {
//         ageCount['36+'] = ageCount['36+']! + 1;
//       }
//
//       // City distribution
//       cityCount[user.city ?? 'Unknown'] = (cityCount[user.city] ?? 0) + 1;
//     }
//
//     setState(() {
//       users = loadedUsers;
//       genderDistribution = genderCount;
//       ageGroupDistribution = ageCount;
//       cityDistribution = cityCount;
//     });
//   }
//
//   Widget _buildStatCard(String title, Widget content) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.poppins(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.redAccent,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(child: content),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         2, // Changed from 3 to 2 pages
//         (index) => Container(
//           width: 8,
//           height: 8,
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: currentPage == index
//                 ? Colors.redAccent
//                 : Colors.redAccent.withOpacity(0.3),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.redAccent.shade400, Colors.redAccent.shade700],
//             ),
//           ),
//         ),
//         title: Text(
//           'Statistics',
//           style: GoogleFonts.poppins(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.redAccent.shade400, Colors.red.shade50],
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentPage = index;
//                   });
//                 },
//                 children: [
//                   // Gender Distribution
//                   _buildStatCard(
//                     'Gender Distribution',
//                     PieChart(
//                       PieChartData(
//                         sections: [
//                           PieChartSectionData(
//                             value: genderDistribution['Male']?.toDouble() ?? 0,
//                             title: 'Male\n${genderDistribution['Male']}',
//                             color: Colors.blue,
//                             radius: 100,
//                           ),
//                           PieChartSectionData(
//                             value:
//                                 genderDistribution['Female']?.toDouble() ?? 0,
//                             title: 'Female\n${genderDistribution['Female']}',
//                             color: Colors.pink,
//                             radius: 100,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // Age Distribution
//                   _buildStatCard(
//                     'Age Distribution',
//                     BarChart(
//                       BarChartData(
//                         alignment: BarChartAlignment.spaceAround,
//                         maxY: ageGroupDistribution.values
//                                 .reduce((a, b) => a > b ? a : b)
//                                 .toDouble() +
//                             2,
//                         titlesData: FlTitlesData(
//                           show: true,
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (value, meta) {
//                                 const titles = [
//                                   '18-25',
//                                   '26-30',
//                                   '31-35',
//                                   '36+'
//                                 ];
//                                 return Text(
//                                   titles[value.toInt()],
//                                   style: GoogleFonts.poppins(fontSize: 12),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         borderData: FlBorderData(show: false),
//                         barGroups: [
//                           BarChartGroupData(x: 0, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['18-25']?.toDouble() ??
//                                   0,
//                               color: Colors.redAccent,
//                             )
//                           ]),
//                           BarChartGroupData(x: 1, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['26-30']?.toDouble() ??
//                                   0,
//                               color: Colors.redAccent,
//                             )
//                           ]),
//                           BarChartGroupData(x: 2, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['31-35']?.toDouble() ??
//                                   0,
//                               color: Colors.redAccent,
//                             )
//                           ]),
//                           BarChartGroupData(x: 3, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['36+']?.toDouble() ?? 0,
//                               color: Colors.redAccent,
//                             )
//                           ]),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildPageIndicator(),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

//region 2
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'database_helper.dart';
// import 'user_class.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class StatisticsPage extends StatefulWidget {
//   const StatisticsPage({super.key});
//
//   @override
//   _StatisticsPageState createState() => _StatisticsPageState();
// }
//
// class _StatisticsPageState extends State<StatisticsPage> {
//   final PageController _pageController = PageController();
//   List<User> users = [];
//   int currentPage = 0;
//   Map<String, int> genderDistribution = {'Male': 0, 'Female': 0};
//   Map<String, int> ageGroupDistribution = {
//     '18-25': 0,
//     '26-30': 0,
//     '31-35': 0,
//     '36+': 0
//   };
//   Map<String, int> cityDistribution = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _loadStatistics();
//   }
//
//   Future<void> _loadStatistics() async {
//     DatabaseHelper databaseHelper = DatabaseHelper.instance;
//     List<User> loadedUsers = await databaseHelper.fetchUsers();
//
//     Map<String, int> genderCount = {'Male': 0, 'Female': 0};
//     Map<String, int> ageCount = {'18-25': 0, '26-30': 0, '31-35': 0, '36+': 0};
//     Map<String, int> cityCount = {};
//
//     for (var user in loadedUsers) {
//       genderCount[user.gender ?? 'Other'] = (genderCount[user.gender] ?? 0) + 1;
//       if (user.age <= 25) {
//         ageCount['18-25'] = ageCount['18-25']! + 1;
//       } else if (user.age <= 30) {
//         ageCount['26-30'] = ageCount['26-30']! + 1;
//       } else if (user.age <= 35) {
//         ageCount['31-35'] = ageCount['31-35']! + 1;
//       } else {
//         ageCount['36+'] = ageCount['36+']! + 1;
//       }
//       cityCount[user.city ?? 'Unknown'] = (cityCount[user.city] ?? 0) + 1;
//     }
//
//     setState(() {
//       users = loadedUsers;
//       genderDistribution = genderCount;
//       ageGroupDistribution = ageCount;
//       cityDistribution = cityCount;
//     });
//   }
//
//   Widget _buildStatCard(String title, Widget content) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.poppins(
//               fontSize: 26,
//               fontWeight: FontWeight.w600,
//               color: Colors.redAccent.shade700,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(child: content),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         3, // Now 3 pages
//             (index) => AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           width: currentPage == index ? 24 : 10,
//           height: 10,
//           margin: const EdgeInsets.symmetric(horizontal: 6),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: currentPage == index
//                 ? Colors.redAccent.shade700
//                 : Colors.redAccent.withOpacity(0.4),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.redAccent.shade400,
//                 Colors.redAccent.shade700,
//               ],
//             ),
//           ),
//         ),
//         title: Text(
//           'Statistics',
//           style: GoogleFonts.poppins(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.redAccent.shade100.withOpacity(0.2),
//               Colors.white,
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentPage = index;
//                   });
//                 },
//                 children: [
//                   // Gender Distribution
//                   _buildStatCard(
//                     'Gender Distribution',
//                     PieChart(
//                       PieChartData(
//                         sectionsSpace: 4,
//                         centerSpaceRadius: 50,
//                         sections: [
//                           PieChartSectionData(
//                             value: genderDistribution['Male']?.toDouble() ?? 0,
//                             title: 'Male\n${genderDistribution['Male']}',
//                             color: Colors.blue.shade600,
//                             radius: 110,
//                             titleStyle: GoogleFonts.poppins(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           PieChartSectionData(
//                             value:
//                             genderDistribution['Female']?.toDouble() ?? 0,
//                             title: 'Female\n${genderDistribution['Female']}',
//                             color: Colors.pink.shade400,
//                             radius: 110,
//                             titleStyle: GoogleFonts.poppins(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // Age Distribution
//                   _buildStatCard(
//                     'Age Distribution',
//                     BarChart(
//                       BarChartData(
//                         alignment: BarChartAlignment.spaceAround,
//                         maxY: (ageGroupDistribution.values
//                             .reduce((a, b) => a > b ? a : b)
//                             .toDouble() *
//                             1.2)
//                             .ceilToDouble(),
//                         titlesData: FlTitlesData(
//                           show: true,
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (value, meta) {
//                                 const titles = [
//                                   '18-25',
//                                   '26-30',
//                                   '31-35',
//                                   '36+'
//                                 ];
//                                 return Text(
//                                   titles[value.toInt()],
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     color: Colors.grey.shade700,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               reservedSize: 40,
//                               getTitlesWidget: (value, meta) {
//                                 return Text(
//                                   value.toInt().toString(),
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         borderData: FlBorderData(show: false),
//                         barGroups: [
//                           BarChartGroupData(x: 0, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['18-25']?.toDouble() ??
//                                   0,
//                               color: Colors.redAccent.shade400,
//                               width: 20,
//                               borderRadius: BorderRadius.circular(4),
//                             )
//                           ]),
//                           BarChartGroupData(x: 1, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['26-30']?.toDouble() ??
//                                   0,
//                               color: Colors.redAccent.shade400,
//                               width: 20,
//                               borderRadius: BorderRadius.circular(4),
//                             )
//                           ]),
//                           BarChartGroupData(x: 2, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['31-35']?.toDouble() ??
//                                   0,
//                               color: Colors.redAccent.shade400,
//                               width: 20,
//                               borderRadius: BorderRadius.circular(4),
//                             )
//                           ]),
//                           BarChartGroupData(x: 3, barRods: [
//                             BarChartRodData(
//                               toY: ageGroupDistribution['36+']?.toDouble() ?? 0,
//                               color: Colors.redAccent.shade400,
//                               width: 20,
//                               borderRadius: BorderRadius.circular(4),
//                             )
//                           ]),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // City Distribution (New Page)
//                   _buildStatCard(
//                     'City Distribution',
//                     PieChart(
//                       PieChartData(
//                         sectionsSpace: 2,
//                         centerSpaceRadius: 40,
//                         sections: cityDistribution.entries.map((entry) {
//                           return PieChartSectionData(
//                             value: entry.value.toDouble(),
//                             title: '${entry.key}\n${entry.value}',
//                             color: Colors.primaries[
//                             cityDistribution.keys.toList().indexOf(entry.key) %
//                                 Colors.primaries.length],
//                             radius: 100,
//                             titleStyle: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildPageIndicator(),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

// endregion

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/api_service.dart';
import 'database_helper.dart';
import 'user_class.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final ApiService _apiService = ApiService();
  final PageController _pageController = PageController();
  List<User> users = [];
  int currentPage = 0;
  Map<String, int> genderDistribution = {'Male': 0, 'Female': 0};
  Map<String, int> ageGroupDistribution = {
    '18-25': 0,
    '26-30': 0,
    '31-35': 0,
    '36+': 0
  };
  Map<String, int> cityDistribution = {};

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    // List<User> loadedUsers = await databaseHelper.fetchUsers();
    List<User> loadedUsers = await _apiService.fetchUsers();

    Map<String, int> genderCount = {'Male': 0, 'Female': 0};
    Map<String, int> ageCount = {'18-25': 0, '26-30': 0, '31-35': 0, '36+': 0};
    Map<String, int> cityCount = {};

    for (var user in loadedUsers) {
      genderCount[user.gender ?? 'Other'] = (genderCount[user.gender] ?? 0) + 1;
      if (user.age <= 25) {
        ageCount['18-25'] = ageCount['18-25']! + 1;
      } else if (user.age <= 30) {
        ageCount['26-30'] = ageCount['26-30']! + 1;
      } else if (user.age <= 35) {
        ageCount['31-35'] = ageCount['31-35']! + 1;
      } else {
        ageCount['36+'] = ageCount['36+']! + 1;
      }
      cityCount[user.city ?? 'Unknown'] = (cityCount[user.city] ?? 0) + 1;
    }

    setState(() {
      users = loadedUsers;
      genderDistribution = genderCount;
      ageGroupDistribution = ageCount;
      cityDistribution = cityCount;
    });
  }

  Widget _buildStatCard(String title, Widget content) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.redAccent.shade700,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // Now 3 pages
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentPage == index ? 24 : 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: currentPage == index
                ? Colors.redAccent.shade700
                : Colors.redAccent.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  Widget _buildCityDistributionChart() {
    // Sort cities by count in descending order
    final sortedCities = cityDistribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Determine if we need to group smaller cities
    const maxDisplayedCities = 6;
    List<MapEntry<String, int>> displayedCities;
    int otherCitiesCount = 0;

    if (sortedCities.length > maxDisplayedCities) {
      displayedCities = sortedCities.sublist(0, maxDisplayedCities);
      otherCitiesCount = sortedCities
          .sublist(maxDisplayedCities)
          .fold(0, (sum, entry) => sum + entry.value);
    } else {
      displayedCities = sortedCities;
    }

    // If we have "Other" cities, add them to the list
    if (otherCitiesCount > 0) {
      displayedCities.add(MapEntry('Other', otherCitiesCount));
    }

    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: displayedCities.map((entry) {
                final index = displayedCities.indexOf(entry);
                return PieChartSectionData(
                  value: entry.value.toDouble(),
                  title: '${entry.key}\n${entry.value}',
                  color: Colors.primaries[index % Colors.primaries.length],
                  radius: 100,
                  titleStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Add a legend below the chart
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: displayedCities.map((entry) {
              final index = displayedCities.indexOf(entry);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    color: Colors.primaries[index % Colors.primaries.length],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${entry.key}: ${entry.value}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
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
            'Statistics',
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
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/dashboard'),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.redAccent.shade100.withOpacity(0.2),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    // Gender Distribution
                    _buildStatCard(
                      'Gender Distribution',
                      PieChart(
                        PieChartData(
                          sectionsSpace: 4,
                          centerSpaceRadius: 50,
                          sections: [
                            PieChartSectionData(
                              value: genderDistribution['Male']?.toDouble() ?? 0,
                              title: 'Male\n${genderDistribution['Male']}',
                              color: Colors.blue.shade600,
                              radius: 110,
                              titleStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value:
                                  genderDistribution['Female']?.toDouble() ?? 0,
                              title: 'Female\n${genderDistribution['Female']}',
                              color: Colors.pink.shade400,
                              radius: 110,
                              titleStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
      
                    // Age Distribution
                    _buildStatCard(
                      'Age Distribution',
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: (ageGroupDistribution.values
                                      .reduce((a, b) => a > b ? a : b)
                                      .toDouble() *
                                  1.2)
                              .ceilToDouble(),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const titles = [
                                    '18-25',
                                    '26-30',
                                    '31-35',
                                    '36+'
                                  ];
                                  return Text(
                                    titles[value.toInt()],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(
                                toY: ageGroupDistribution['18-25']?.toDouble() ??
                                    0,
                                color: Colors.redAccent.shade400,
                                width: 20,
                                borderRadius: BorderRadius.circular(4),
                              )
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                toY: ageGroupDistribution['26-30']?.toDouble() ??
                                    0,
                                color: Colors.redAccent.shade400,
                                width: 20,
                                borderRadius: BorderRadius.circular(4),
                              )
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(
                                toY: ageGroupDistribution['31-35']?.toDouble() ??
                                    0,
                                color: Colors.redAccent.shade400,
                                width: 20,
                                borderRadius: BorderRadius.circular(4),
                              )
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(
                                toY: ageGroupDistribution['36+']?.toDouble() ?? 0,
                                color: Colors.redAccent.shade400,
                                width: 20,
                                borderRadius: BorderRadius.circular(4),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
      
                    // City Distribution (Improved)
                    _buildStatCard(
                      'City Distribution',
                      _buildCityDistributionChart(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildPageIndicator(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
