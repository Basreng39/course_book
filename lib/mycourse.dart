import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'booking_detail.dart';

void main() {
  runApp(MaterialApp(
    home: MyCoursesPage(),
  ));
}

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);
  @override
  _MyCoursesPageState createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  final List<Course> _bookedCourses = [
    Course('Basic Drawing Techniques', 'assets/bookingConfirmed.png', 'Mr. James', 'assets/pp.jpg', '9.5', '6hr', '12 Sections', '23 July 2024', '\$30', 'https://via.placeholder.com/17x17', false),
    // Add more booked courses as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Courses'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Booking History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),

            // List of Booked Courses
            ..._bookedCourses.map((course) => BookedCourseCard(
              imageUrl: course.imageUrl,
              title: course.title,
              instructorName: course.instructorName,
              instructorImage: course.instructorImage,
              rating: course.rating,
              duration: course.duration,
              sections: course.sections,
              startDate: course.startDate,
              price: course.price,
              languageIcon: course.languageIcon,
              isPaymentUploaded: course.isPaymentUploaded,
              onPaymentUpload: () {
                setState(() {
                  course.isPaymentUploaded = true;
                });
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
}

class Course {
  final String title;
  final String imageUrl;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String sections;
  final String startDate;
  final String price;
  final String languageIcon;
  bool isPaymentUploaded;

  Course(
    this.title,
    this.imageUrl,
    this.instructorName,
    this.instructorImage,
    this.rating,
    this.duration,
    this.sections,
    this.startDate,
    this.price,
    this.languageIcon,
    this.isPaymentUploaded,
  );
}

class BookedCourseCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String sections;
  final String startDate;
  final String price;
  final String languageIcon;
  final bool isPaymentUploaded;
  final VoidCallback onPaymentUpload;

  const BookedCourseCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.instructorName,
    required this.instructorImage,
    required this.rating,
    required this.duration,
    required this.sections,
    required this.startDate,
    required this.price,
    required this.languageIcon,
    required this.isPaymentUploaded,
    required this.onPaymentUpload,
  }) : super(key: key);

  @override
  _BookedCourseCardState createState() => _BookedCourseCardState();
}

class _BookedCourseCardState extends State<BookedCourseCard> {
  File? _paymentProof;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _paymentProof = File(pickedFile.path);
      });
      widget.onPaymentUpload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BookingDetail.showBookingDetail(
          context,
          widget.title,
          widget.instructorName,
          widget.instructorImage,
          widget.rating,
          widget.duration,
          widget.price,
          ['English', 'Arab'],
          widget.startDate,
          widget.sections,
          '"Basic Drawing Techniques" covers foundational skills essential for creating compelling artwork, including line work, shading, and perspective. This course is ideal for beginners aiming to develop their drawing abilities and artistic confidence.', // Update with appropriate course description
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Container(
                      width: 334,
                      height: 182,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        image: DecorationImage(
                          image: AssetImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: -15,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: -25,
                  child: Container(
                    width: 115,
                    height: 42,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 115,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 77,
                          top: 4,
                          child: ClipOval(
                            child: Image.asset(
                              widget.instructorImage,
                              width: 33,
                              height: 33,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 13,
                          top: 12,
                          child: Text(
                            widget.instructorName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 17.0, 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        widget.rating,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22.0, 0.0, 15.0, 10.0),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 17, color: Color(0xFF999999)),
                  SizedBox(width: 8),
                  Text(
                    widget.duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(Icons.book, size: 17, color: Color(0xFF999999)),
                  SizedBox(width: 8),
                  Text(
                    widget.sections,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today, size: 17, color: Color(0xFF999999)),
                  SizedBox(width: 8),
                  Text(
                    'Start: ${widget.startDate}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (widget.isPaymentUploaded)
                    Text(
                      'Booking Confirmed',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  else
                    Column(
                      children: [
                        Text(
                          'Upload Payment Proof',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(Icons.upload),
                          label: Text('Upload'),
                        ),
                      ],
                    ),
                  if (_paymentProof != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.file(
                        _paymentProof!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
