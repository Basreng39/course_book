import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_book/models/course.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Course>> getCourses({String? search}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/courses${search != null ? '?search=$search' : ''}'),
      );

      if (response.statusCode == 200) {
        // Debugging: Print the response body to check its structure
        print('Response body: ${response.body}');

        List<dynamic> body = json.decode(response.body)['data'];

        // Debugging: Print the parsed body to see if it matches the expected structure
        print('Parsed body: $body');

        return body.map((dynamic item) => Course.fromJson(item)).toList();
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print('Failed to load courses, status code: ${response.statusCode}');
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      // Print the exception for debugging
      print('Exception caught: $e');
      throw e;
    }
  }

  Future<Course> getCourse(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/courses/$id'));

      if (response.statusCode == 200) {
        // Debugging: Print the response body
        print('Response body: ${response.body}');

        return Course.fromJson(json.decode(response.body));
      } else {
        print('Failed to load course, status code: ${response.statusCode}');
        throw Exception('Failed to load course');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw e;
    }
  }
}
