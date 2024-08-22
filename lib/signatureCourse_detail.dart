import 'package:flutter/material.dart';
// import 'package:course_book/mybooking.dart';
import 'package:course_book/services/booking_service.dart';
import 'package:course_book/models/booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navbar.dart';

class SignatureCourseDetail extends StatelessWidget {
  final int courseId;
  final int instrukturId;
  final String title;
  final String imageUrl;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String price;
  final List<String> languages;
  final String startDate;
  final String meetings;
  final String description;

  const SignatureCourseDetail({
    Key? key,
    required this.courseId,
    required this.instrukturId,
    required this.title,
    required this.imageUrl,
    required this.instructorName,
    required this.instructorImage,
    required this.rating,
    required this.duration,
    required this.price,
    required this.languages,
    required this.startDate,
    required this.meetings,
    required this.description,
  }) : super(key: key);

  Future<void> _createBooking(BuildContext context) async {
    BookingService bookingService = BookingService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('id') ?? 0;

    if (userId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    Booking newBooking = Booking(
      id: 0,
      userId: userId,
      courseId: courseId,
      instrukturId: instrukturId,
      status: 'Pending',
    );

    Booking? createdBooking = await bookingService.createBooking(newBooking);

    if (createdBooking != null) {
      _showBookingPending(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create booking.')),
      );
    }
  }

  void _showBookingPending(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          backgroundColor: Color(0xFFD2EFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: 280,
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/panding.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Booking Pending!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your booking is pending. Please upload your payment proof.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 14,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Navbar(selectedIndex: 2),
                    ),
                  );
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF007BFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
                      // Image
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
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
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
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              placeholder: '', // Remove the asset placeholder
                              image: instructorImage,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) {
                                return Icon(
                                  Icons
                                      .person, // Display a people or human icon while loading
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
                          )
                        ],
                      ),
                      SizedBox(height: 16),

                      // Rating, Duration, and Price
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                SizedBox(width: 5),
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
                                SizedBox(width: 5),
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
                                SizedBox(width: 5),
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

                      // Meetings
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
                              meetings,
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  _createBooking(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF40B59F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(150, 40),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showCourseDetails(
      BuildContext context,
      int courseId,
      int instrukturId,
      String title,
      String imageUrl,
      String instructorName,
      String instructorImage,
      String rating,
      String duration,
      String price,
      List<String> languages,
      String startDate,
      String sections,
      String deskripsi) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SignatureCourseDetail(
          courseId: courseId,
          instrukturId: instrukturId,
          title: title,
          imageUrl: imageUrl,
          instructorName: instructorName,
          instructorImage: instructorImage,
          rating: rating,
          duration: duration,
          price: price,
          languages: languages,
          startDate: startDate,
          meetings: sections,
          description: deskripsi,
        );
      },
    );
  }
}
