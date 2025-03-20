import 'dart:convert';
import 'package:http/http.dart' as http;
import '../user_class.dart';

//working with mockapi.io and storing data in database
// class ApiService {
//   final String baseUrl =
//       'https://67c3db4c89e47db83dd2a1c3.mockapi.io/matrimony_api';

//   // Future<List<User>> fetchUsers() async {
//   //   try {
//   //     print('Attempting to fetch users from: $baseUrl');
//   //     final response = await http.get(Uri.parse(baseUrl));
//   //     print('Response status code: ${response.statusCode}');
//   //     print('Response body: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       List<dynamic> jsonData = json.decode(response.body);
//   //       return jsonData.map((data) => User.fromJson(data)).toList();
//   //     } else {
//   //       throw Exception('Failed to load users: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('API Error Details: $e');
//   //     throw Exception('Error fetching users: $e');
//   //   }
//   // }
//   Future<List<User>> fetchUsers() async {
//     try {
//       print('Attempting to fetch users from: $baseUrl');
//       final response = await http.get(Uri.parse(baseUrl));
//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((data) {
//           // Ensure isFavorite is properly parsed from the API response
//           data['isFavorite'] =
//               data['isFavorite'] == true || data['isFavorite'] == 1;
//           return User.fromJson(data);
//         }).toList();
//       } else {
//         throw Exception('Failed to load users: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('API Error Details: $e');
//       throw Exception('Error fetching users: $e');
//     }
//   }

//   Future<User> createUser(Map<String, dynamic> userData) async {
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(userData),
//       );
//       if (response.statusCode == 201) {
//         return User.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to create user: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error creating user: $e');
//     }
//   }

//   Future<User> updateUser(User user) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/${user.id}'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(user.toJson()),
//       );
//       if (response.statusCode == 200) {
//         return User.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to update user: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error updating user: $e');
//     }
//   }

//   Future<void> deleteUser(String id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/$id'));
//       if (response.statusCode != 200) {
//         throw Exception('Failed to delete user: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error deleting user: $e');
//     }
//   }
// }

class ApiService {
  final String baseUrl =
      'https://67c3db4c89e47db83dd2a1c3.mockapi.io/matrimony_api';

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => User.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<User> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

//   Future<User> updateUser(Map<String, dynamic> userData) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/${userData['id']}'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(userData),
//       );

//       if (response.statusCode == 200) {
//         return User.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to update user: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error updating user: $e');
//     }
//   }
// }
  Future<User> updateUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${userData['id']}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        return User.fromJson(userData);
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      return User.fromJson(userData);
    }
  }
}
