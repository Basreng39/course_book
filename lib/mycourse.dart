// import 'dart:typed_data';
// import 'package:course_book/booking_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'models/booking_model.dart';
// import 'services/booking_service.dart';
// import 'models/course.dart';
// import 'services/course_services.dart';

// class MyCoursesPage extends StatefulWidget {
//   const MyCoursesPage({Key? key}) : super(key: key);

//   @override
//   _MyCoursesPageState createState() => _MyCoursesPageState();
// }

// class _MyCoursesPageState extends State<MyCoursesPage> {
//   final BookingService _bookingService = BookingService();
//   List<Booking> _bookedCourses = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookings();
//   }

//   Future<void> _fetchBookings() async {
//     final bookings = await _bookingService
//         .getBookingsByUserId(1); // Replace with actual user ID as needed
//     setState(() {
//       _bookedCourses = bookings;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Bookings'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Booking History',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 15),
//             ..._bookedCourses.map((booking) => BookedCourseCard(
//                   booking: booking,
//                   onPaymentUpload: (Uint8List paymentProofBytes) async {
//                     try {
//                       final fileUrl = await _bookingService.uploadBuktiTransfer(
//                           paymentProofBytes, 'bukti_transfer.png');
//                       if (fileUrl != null) {
//                         final updatedBooking =
//                             await _bookingService.updateBooking(
//                           booking.id,
//                           'Pending Validation',
//                           fileUrl,
//                         );
//                         if (updatedBooking != null) {
//                           setState(() {
//                             booking.status = 'Pending Validation';
//                             booking.buktiTransfer = fileUrl;
//                           });
//                         } else {
//                           print("Error: Failed to update booking.");
//                         }
//                       } else {
//                         print("Error: Failed to upload payment proof.");
//                       }
//                     } catch (e) {
//                       print("Exception during payment upload: $e");
//                     }
//                   },
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BookedCourseCard extends StatefulWidget {
//   final Booking booking;
//   final Function(Uint8List) onPaymentUpload;

//   const BookedCourseCard({
//     Key? key,
//     required this.booking,
//     required this.onPaymentUpload,
//   }) : super(key: key);

//   @override
//   _BookedCourseCardState createState() => _BookedCourseCardState();
// }

// class _BookedCourseCardState extends State<BookedCourseCard> {
//   Course? course;
//   Instruktur? instruktur;
//   Uint8List? _imageBytes;
//   String? _fileName;
//   final ImagePicker _picker = ImagePicker();

//   final ApiService _apiService =
//       ApiService(baseUrl: 'http://192.168.100.151:8000/api');
//       // ApiService(baseUrl: 'http://127.0.0.1:8000/api');

//   @override
//   void initState() {
//     super.initState();
//     _fetchDetails();
//   }

//   Future<void> _fetchDetails() async {
//     try {
//       course = await _apiService.getCourse(widget.booking.courseId);
//       instruktur = course?.instruktur;
//       setState(() {});
//     } catch (e) {
//       print("Error fetching details: $e");
//     }
//   }

//   Future<void> _pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         final fileBytes = await pickedFile.readAsBytes();
//         final fileName = pickedFile.name;
//         setState(() {
//           _imageBytes = fileBytes;
//           _fileName = fileName;
//         });

//         _showUploadDialog(context); // Call the dialog
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//     }
//   }

//   void _showUploadDialog(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return PaymentScreen(
//           bookingId: widget.booking.id.toString(),
//           price: course != null ? '\$${course!.harga}' : 'Loading...',
//           imageBytes: _imageBytes,
//           onConfirm: () async {
//             if (_imageBytes != null) {
//               await widget.onPaymentUpload(_imageBytes!);
//               Navigator.of(context).pop(); // Close the dialog after upload
//             }
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (course != null && instruktur != null) {
//           BookingDetail.showBookingDetail(
//             context,
//             course!.nama,
//             instruktur!.nama,
//             instruktur!.fullImageUrl,
//             course!.fullGambarUrl,
//             course!.rating,
//             '${course!.jamPelajaran} hr',
//             '\$${course!.harga}',
//             [course!.language],
//             course!.formattedStartCourse,
//             '${course!.jumlahPertemuan} Sections',
//             course!.deskripsi,
//             widget.booking.status == 'Booked',
//           );
//         } else {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Data Unavailable'),
//               content: Text(
//                   'Course or Instructor details are still loading. Please try again in a moment.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 334,
//                       height: 182,
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(15)),
//                         image: DecorationImage(
//                           image: NetworkImage(widget.booking.status == 'Pending'
//                               ? 'assets/bookingPending.png'
//                               : 'assets/bookingConfirmed.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 10,
//                     bottom: -15,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(0x3F000000),
//                             blurRadius: 4,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         course != null ? '\$${course!.harga}' : 'Loading...',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 10,
//                     bottom: -15,
//                     child: Container(
//                       width: 115,
//                       height: 42,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 115,
//                               height: 42,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0x3F000000),
//                                     blurRadius: 4,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 77,
//                             top: 4,
//                             child: ClipOval(
//                               child: instruktur != null
//                                   ? FadeInImage.assetNetwork(
//                                       placeholder: 'assets/pp.jpg',
//                                       image: instruktur!.fullImageUrl,
//                                       width: 33,
//                                       height: 33,
//                                       fit: BoxFit.cover,
//                                       imageErrorBuilder:
//                                           (context, error, stackTrace) {
//                                         return Image.asset(
//                                           'assets/error.jpg',
//                                           width: 33,
//                                           height: 33,
//                                           fit: BoxFit.cover,
//                                         );
//                                       },
//                                     )
//                                   : Image.asset(
//                                       'assets/pp.jpg',
//                                       width: 33,
//                                       height: 33,
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 13,
//                             top: 12,
//                             child: Text(
//                               instruktur?.nama ?? 'Loading...',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 25),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     course?.nama ?? 'Loading...',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber, size: 20),
//                       SizedBox(width: 4),
//                       Text(
//                         course?.rating ?? 'Loading...',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5),
//               Row(
//                 children: [
//                   Icon(Icons.access_time, size: 17, color: Color(0xFF999999)),
//                   SizedBox(width: 8),
//                   Text(
//                     course != null
//                         ? '${course!.jamPelajaran} hr'
//                         : 'Loading...',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF999999),
//                     ),
//                   ),
//                   SizedBox(width: 25),
//                   Icon(Icons.book, size: 17, color: Color(0xFF999999)),
//                   SizedBox(width: 8),
//                   Text(
//                     course != null
//                         ? '${course!.jumlahPertemuan} Sections'
//                         : 'Loading...',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF999999),
//                     ),
//                   ),
//                   Spacer(),
//                   Icon(Icons.calendar_today,
//                       size: 17, color: Color(0xFF999999)),
//                   SizedBox(width: 8),
//                   Text(
//                     course != null
//                         ? 'Start: ${course!.formattedStartCourse}'
//                         : 'Loading...',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF999999),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Column(
//                 children: [
//                   if (widget.booking.status == 'Booked')
//                     Text(
//                       'Booking Confirmed',
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     )
//                   else if (widget.booking.status == 'Pending Validation')
//                     Text(
//                       'Waiting for admin validation...',
//                       style: TextStyle(
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     )
//                   else if (widget.booking.status == 'Rejected')
//                     Text(
//                       'Payment proof rejected. Please re-upload!',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     )
//                   else
//                     Column(
//                       children: [
//                         Text(
//                           'Upload Payment Proof',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         ElevatedButton.icon(
//                           onPressed: _pickImage,
//                           icon: Icon(Icons.upload),
//                           label: Text('Upload'),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PaymentScreen extends StatelessWidget {
//   final String bookingId;
//   final String price;
//   final Uint8List? imageBytes;
//   final VoidCallback onConfirm;

//   PaymentScreen({
//     required this.bookingId,
//     required this.price,
//     required this.imageBytes,
//     required this.onConfirm,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Determine if the screen is wide enough (e.g., desktop or large tablet)
//         final isWideScreen = constraints.maxWidth > 600;

//         return Container(
//           padding: const EdgeInsets.all(16.0),
//           height: isWideScreen ? 400 : 300,
//           width: isWideScreen ? 500 : double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Booking ID: $bookingId',
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Price: $price',
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 16),
//               if (imageBytes != null)
//                 Image.memory(
//                   imageBytes!,
//                   height: isWideScreen ? 200 : 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: onConfirm,
//                 child: Text('Submit'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(isWideScreen ? 200 : double.infinity,
//                       50), // Adjust button size based on screen
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MyCoursesPage(),
//   ));
// }
