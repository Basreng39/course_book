import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_book/models/course.dart';

class CourseService {
  final String apiUrl = 'http://127.0.0.1:8000/api/courses/';

  Future<List<Course>> fetchCoursesByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('$apiUrl/courses?category_id=$categoryId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
