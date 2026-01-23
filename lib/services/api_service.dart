import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://randomuser.me/api/';

  Future<List<User>> fetchUsers({
    required int page,
    required int results,
  }) async {
    final uri = Uri.parse('$baseUrl?results=$results&page=$page&seed=users_app');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final resultsList = data['results'] as List<dynamic>;
      return resultsList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }
}