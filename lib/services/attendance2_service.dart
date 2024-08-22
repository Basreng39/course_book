import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_book/models/attendance2.dart';

class Attendance2Service {
  final String baseUrl;

  Attendance2Service({required this.baseUrl});

  Future<List<Attendance2>> fetchAttendances() async {
    final response = await http.get(Uri.parse('$baseUrl/attendances'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Attendance2.fromJson(json)).toList();
    } else {
      print('Failed to load attendances: ${response.body}');
      throw Exception('Failed to load attendances');
    }
  }

  Future<Attendance2> createAttendance(
      int bookingId, String date, String? attendanceProof) async {
    final response = await http.post(
      Uri.parse('$baseUrl/attendances'),
      body: {
        'booking_id': bookingId.toString(),
        'date': date,
        'attendance_proof': attendanceProof,
      },
    );

    if (response.statusCode == 201) {
      return Attendance2.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create attendance');
    }
  }

  Future<Attendance2> updateAttendance(int id, String? attendanceProof) async {
    final response = await http.put(
      Uri.parse('$baseUrl/attendances/$id'),
      body: {
        'attendance_proof': attendanceProof,
      },
    );

    if (response.statusCode == 200) {
      return Attendance2.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update attendance');
    }
  }

  Future<void> deleteAttendance(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/attendances/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete attendance');
    }
  }
}
