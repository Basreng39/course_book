import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class BookingDetail extends StatelessWidget {
  final String title;
  final String instructorName;
  final String instructorImage;
  final String courseImage;
  final String rating;
  final String duration;
  final String price;
  final List<String> languages;
  final String startDate;
  final String jumlahPertemuan;
  final String description;
  final bool isConfirmed;

  const BookingDetail({
    Key? key,
    required this.title,
    required this.instructorName,
    required this.instructorImage,
    required this.courseImage,
    required this.rating,
    required this.duration,
    required this.price,
    required this.languages,
    required this.startDate,
    required this.jumlahPertemuan,
    required this.description,
    required this.isConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Gambar Kursus
                          Container(
                            width: double.infinity,
                            height: 192,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(courseImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Overlay status booking
                          Positioned(
                            top: 14,
                            right: 15,
                            left: 15,
                            child: Container(
                              width: double.infinity,
                              height: 163,
                              decoration: BoxDecoration(
                                color: Color(0xFFD2EFFF),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(isConfirmed
                                            ? "assets/Check.png"
                                            : "assets/panding.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    isConfirmed
                                        ? 'Booking Confirmed!'
                                        : 'Booking Pending...',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    isConfirmed
                                        ? 'You have successfully booked the course.'
                                        : 'Your booking is pending.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 14,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  if (!isConfirmed)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Please Upload your payment proof!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Instructor Name and Image
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              instructorName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              placeholder: '',
                              image: instructorImage,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 40,
                                );
                              },
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/error.jpg',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Rating, Duration, and Price
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                Text(
                                  rating,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Colors.grey, size: 20),
                                Text(
                                  duration,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.attach_money,
                                    color: Colors.grey, size: 20),
                                Text(
                                  price,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Languages
                      Row(
                        children: [
                          Icon(Icons.language, color: Colors.grey, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Languages:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              languages.join(', '),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Start Date
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.grey, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Start Date:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              startDate,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // jumlahPertemuan
                      Row(
                        children: [
                          Icon(Icons.event, color: Colors.grey, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Meetings:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              jumlahPertemuan,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Description
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      // Tombol Upload Payment Proof di bagian bawah
                      if (!isConfirmed)
                        ElevatedButton(
                          onPressed: () {
                            // Navigasi ke PaymentScreen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(
                                  bookingId: '12345',
                                  price: price,
                                  onConfirm: () {
                                    // Handle payment confirmation
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text('Upload Payment Proof'),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  static void showBookingDetail(
    BuildContext context,
    String title,
    String instructorName,
    String instructorImage,
    String courseImage,
    String rating,
    String duration,
    String price,
    List<String> languages,
    String startDate,
    String jumlahPertemuan,
    String description,
    bool isConfirmed,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BookingDetail(
          title: title,
          instructorName: instructorName,
          instructorImage: instructorImage,
          courseImage: courseImage,
          rating: rating,
          duration: duration,
          price: price,
          languages: languages,
          startDate: startDate,
          jumlahPertemuan: jumlahPertemuan,
          description: description,
          isConfirmed: isConfirmed,
        );
      },
    );
  }
}

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
        color: Colors.grey[900],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Detail Pembayaran',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
              : Text('Tidak ada gambar terpilih',
                  style: TextStyle(color: Colors.white)),
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
