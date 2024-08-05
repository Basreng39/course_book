import 'package:flutter/material.dart';

class BookingDetail extends StatelessWidget {
  final String title;
  final String instructorName;
  final String instructorImage;
  final String rating;
  final String duration;
  final String price;
  final List<String> languages;
  final String startDate;
  final String meetings;
  final String description;

  const BookingDetail({
    Key? key,
    required this.title,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          Stack(
            clipBehavior: Clip.none, // Ensure text is visible even if it overflows
            children: [
              // Main Image
              Container(
                width: 345,
                height: 192,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage('assets/basicDraw.png'), // Replace with the correct image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // "Booking Confirmed!" Overlay
              Positioned(
                top: 14,
                right: 15,
                child: Container(
                  width: 314,
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
                            image: AssetImage("assets/Check.png"), // Replace with the correct image
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        'Booking Confirmed!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'You have successfully booked the course.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Title
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
                      child: Image.asset(
                        instructorImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
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
                          Icon(Icons.access_time, color: Colors.grey, size: 20),
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
                          Icon(Icons.attach_money, color: Colors.grey, size: 20),
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
                    Expanded(
                      child: Text(
                        'Languages:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                    Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Start Date:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                    Expanded(
                      child: Text(
                        'Meetings:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void showBookingDetail(
    BuildContext context,
    String title,
    String instructorName,
    String instructorImage,
    String rating,
    String duration,
    String price,
    List<String> languages,
    String startDate,
    String meetings,
    String description,
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
          rating: rating,
          duration: duration,
          price: price,
          languages: languages,
          startDate: startDate,
          meetings: meetings,
          description: description,
        );
      },
    );
  }
}
