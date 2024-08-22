import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:course_book/models/payment_model.dart';

class PaymentService {
  final String baseUrl;

  PaymentService(this.baseUrl);

  // Menampilkan daftar payments
  Future<List<Payment>> getPayments() async {
    final response = await http.get(Uri.parse('$baseUrl/api/payments'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Payment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  // Menyimpan payment baru
  Future<Payment> createPayment({
    required int bookingId,
    required int userId,
    required String paymentProofPath,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/api/payments'),
    )
      ..fields['booking_id'] = bookingId.toString()
      ..fields['user_id'] = userId.toString()
      ..files.add(await http.MultipartFile.fromPath('payment_proof', paymentProofPath));

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      return Payment.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to create payment');
    }
  }

  // Menampilkan detail payment
  Future<Payment> getPayment(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/payments/$id'));

    if (response.statusCode == 200) {
      return Payment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load payment');
    }
  }

  // Mengupdate status payment
  Future<Payment> updatePaymentStatus(int id, String status) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/payments/$id'),
      body: json.encode({'status': status}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Payment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update payment status');
    }
  }

  // Menghapus payment
  Future<void> deletePayment(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/payments/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete payment');
    }
  }
}
