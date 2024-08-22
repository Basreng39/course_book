import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class PaymentScreen extends StatelessWidget {
  final String bookingId;
  final String price;
  final Uint8List? imageBytes;
  final Function onConfirm;

  const PaymentScreen({
    required this.bookingId,
    required this.price,
    this.imageBytes,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 235, 235),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Detail Pembayaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'ID Pemesanan: $bookingId',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            'Harga: $price',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 10),
          imageBytes != null
              ? Image.memory(
                  imageBytes!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text('Tidak ada gambar terpilih', style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              onConfirm();
            },
            child: Text('Konfirmasi Pembayaran'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF746EBD), // Background color
            ),
          ),
        ],
      ),
    );
  }
}
