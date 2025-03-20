// class User {
//   int? id;
//   String? name;
//   String? gender;
//   String? dob;  // Date of Birth (used for calculating age)
//   String? maritalStatus;
//   String? country;
//   String? state;
//   String? city;
//   String? religion;
//   String? caste;
//   String? subCaste;
//   String? education;
//   String? occupation;
//   String? email;
//   String? phone;
//   bool isFavorite;
//
//   User({
//     this.id,
//     this.name,
//     this.gender,
//     this.dob,
//     this.maritalStatus,
//     this.country,
//     this.state,
//     this.city,
//     this.religion,
//     this.caste,
//     this.subCaste,
//     this.education,
//     this.occupation,
//     this.email,
//     this.phone,
//     this.isFavorite = false,
//   });
//
//   // Method to calculate age based on dob
//   int get age {
//     if (dob == null || dob!.isEmpty) return 0;  // Return 0 if dob is not set
//     DateTime birthDate = DateTime.parse(dob!); // Ensure dob is in "YYYY-MM-DD" format
//     DateTime now = DateTime.now();
//     int calculatedAge = now.year - birthDate.year;
//     if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
//       calculatedAge--; // Subtract 1 if birthday hasn't occurred yet this year
//     }
//     return calculatedAge;
//   }
//
//   // Convert user data to a map (for storing in the database)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'gender': gender,
//       'dob': dob,
//       'maritalStatus': maritalStatus,
//       'country': country,
//       'state': state,
//       'city': city,
//       'religion': religion,
//       'caste': caste,
//       'subCaste': subCaste,
//       'education': education,
//       'occupation': occupation,
//       'email': email,
//       'phone': phone,
//       'isFavorite': isFavorite ? 1 : 0, // Store isFavorite as 1 or 0
//     };
//   }
//
//   // Convert from a map to a User instance
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'],
//       name: map['name'],
//       gender: map['gender'],
//       dob: map['dob'],
//       maritalStatus: map['maritalStatus'],
//       country: map['country'],
//       state: map['state'],
//       city: map['city'],
//       religion: map['religion'],
//       caste: map['caste'],
//       subCaste: map['subCaste'],
//       education: map['education'],
//       occupation: map['occupation'],
//       email: map['email'],
//       phone: map['phone'],
//       isFavorite: map['isFavorite'] == 1, // Convert isFavorite back to boolean
//     );
//   }
// }

import 'package:intl/intl.dart';

class User {
  String? id;
  String? name;
  String? gender;
  String? dob;
  String? maritalStatus;
  String? country;
  String? state;
  String? city;
  String? religion;
  String? caste;
  String? subCaste;
  String? education;
  String? occupation;
  String? email;
  String? phone;
  bool isFavorite;

  User({
    this.id,
    this.name,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.country,
    this.state,
    this.city,
    this.religion,
    this.caste,
    this.subCaste,
    this.education,
    this.occupation,
    this.email,
    this.phone,
    this.isFavorite = false,
  });

  // Method to calculate age based on dob
  // int get age {
  //   if (dob == null || dob!.isEmpty) return 0;  // Return 0 if dob is not set
  //   try {
  //     DateTime birthDate = DateTime.parse(dob!); // Ensure dob is in "YYYY-MM-DD" format
  //     DateTime now = DateTime.now();
  //     int calculatedAge = now.year - birthDate.year;
  //     if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
  //       calculatedAge--; // Subtract 1 if birthday hasn't occurred yet this year
  //     }
  //     return calculatedAge;
  //   } catch (e) {
  //     print("Error parsing DOB: $dob");
  //     return 0;  // Return 0 if there is an error in parsing dob
  //   }
  // }
  int get age {
    if (dob == null || dob!.isEmpty) return 0; // Return 0 if dob is not set
    try {
      DateTime birthDate =
          DateFormat('dd-MM-yyyy').parse(dob!); // Parse in 'dd-MM-yyyy' format
      DateTime now = DateTime.now();
      int calculatedAge = now.year - birthDate.year;

      // Adjust if birthday hasn't occurred yet this year
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        calculatedAge--;
      }
      return calculatedAge;
    } catch (e) {
      print("Error parsing DOB: $dob");
      return 0; // Return 0 if parsing fails
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'dob': dob,
      'maritalStatus': maritalStatus,
      'country': country,
      'state': state,
      'city': city,
      'religion': religion,
      'caste': caste,
      'subCaste': subCaste,
      'education': education,
      'occupation': occupation,
      'email': email,
      'phone': phone,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      dob: map['dob'],
      maritalStatus: map['maritalStatus'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      religion: map['religion'],
      caste: map['caste'],
      subCaste: map['subCaste'],
      education: map['education'],
      occupation: map['occupation'],
      email: map['email'],
      phone: map['phone'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name'],
      gender: json['gender'],
      dob: json['dob'],
      maritalStatus: json['maritalStatus'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      religion: json['religion'],
      caste: json['caste'],
      subCaste: json['subCaste'],
      education: json['education'],
      occupation: json['occupation'],
      email: json['email'],
      phone: json['phone'],
      isFavorite: json['isFavorite'] == true || json['isFavorite'] == 1,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'age': age,
  //     'gender': gender,
  //     'city': city,
  //     'email': email,
  //     'phone': phone,
  //     'occupation': occupation,
  //     'isFavorite': isFavorite,
  //   };
  // }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'dob': dob,
      'maritalStatus': maritalStatus,
      'country': country,
      'state': state,
      'city': city,
      'religion': religion,
      'caste': caste,
      'subCaste': subCaste,
      'education': education,
      'occupation': occupation,
      'email': email,
      'phone': phone,
      'isFavorite': isFavorite,
    };
  }
}