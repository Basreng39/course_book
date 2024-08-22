import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import '../models/booking_model.dart';

class BookingService {
  // final String baseUrl = 'http://127.0.0.1:8000/api';
  final String baseUrl = 'http://192.168.100.151:8000/api';

  Future<List<Booking>> getBookings() async {
    final url = Uri.parse('$baseUrl/bookings');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((booking) => Booking.fromJson(booking)).toList();
      } else {
        throw Exception('Failed to fetch bookings: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      return [];
    }
  }

  Future<Booking?> createBooking(Booking booking) async {
    final url = Uri.parse('$baseUrl/bookings');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(booking.toJson()),
      );

      if (response.statusCode == 201) {
        return Booking.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create booking: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<Booking?> updateBooking(int id, String status, String fileUrl) async {
    final url = Uri.parse('$baseUrl/bookings/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status, 'bukti_transfer': fileUrl}),
      );
      if (response.statusCode == 200) {
        return Booking.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update booking: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  // Method to upload bukti transfer (payment proof)
  Future<String?> uploadBuktiTransfer(
      Uint8List fileBytes, String fileName) async {
    final uri = Uri.parse('$baseUrl/upload_bukti_transfer');
    final request = http.MultipartRequest('POST', uri);

    // Attach payment proof file
    final multipartFile = http.MultipartFile.fromBytes(
      'bukti_transfer',
      fileBytes,
      filename: fileName,
      contentType:
          MediaType('image', 'jpeg'), // Adjust the content type if necessary
    );
    request.files.add(multipartFile);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);
        return jsonData['file_url']; // URL path for the uploaded bukti transfer
      } else {
        throw Exception('Failed to upload file: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred while uploading file: $e');
      return null;
    }
  }

  Future<List<Booking>> getBookingsByUserId(int userId) async {
    final url = Uri.parse('$baseUrl/bookings?user_id=$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((booking) => Booking.fromJson(booking)).toList();
      } else {
        throw Exception('Failed to fetch bookings: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      return [];
    }
  }
}
