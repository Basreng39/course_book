import 'package:flutter/material.dart';
import 'models/booking_model.dart';
import 'services/booking_service.dart';
import 'models/course.dart';
import 'services/course_services.dart';
import 'package:course_book/booking_detail.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  final BookingService _bookingService = BookingService();
  List<Booking> _kursusYangDipesan = [];

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      final bookings = await _bookingService
          .getBookingsByUserId(1); // Ganti dengan ID pengguna yang sebenarnya
      setState(() {
        _kursusYangDipesan = bookings;
      });
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booking'),
      ),
      body: _kursusYangDipesan.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _kursusYangDipesan.length,
              itemBuilder: (context, index) {
                return KartuKursusDipesan(booking: _kursusYangDipesan[index]);
              },
            ),
    );
  }
}

class KartuKursusDipesan extends StatefulWidget {
  final Booking booking;

  const KartuKursusDipesan({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  _KartuKursusDipesanState createState() => _KartuKursusDipesanState();
}

class _KartuKursusDipesanState extends State<KartuKursusDipesan> {
  Course? course;
  Instruktur? instruktur;
  bool isLoading = true;

  final ApiService _apiService =
      ApiService(baseUrl: 'http://192.168.100.151:8000/api');
      // ApiService(baseUrl: 'http://127.0.0.1:8000/api');

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      course = await _apiService.getCourse(widget.booking.courseId);
      instruktur = course?.instruktur;
    } catch (e) {
      print("Error fetching course details: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateToBookingDetail() {
    if (course != null && instruktur != null) {
      BookingDetail.showBookingDetail(
        context,
        course!.nama,
        instruktur!.nama,
        instruktur!.fullImageUrl,
        course!.fullGambarUrl,
        course!.rating,
        '${course!.jamPelajaran} hr',
        '\$${course!.harga}',
        [course!.language],
        course!.formattedStartCourse,
        '${course!.jumlahPertemuan} Sections',
        course!.deskripsi,
        widget.booking.status == 'Dipesan',
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Tidak Tersedia'),
          content: Text(
              'Detail kursus atau instruktur masih memuat atau tidak tersedia. Silakan coba lagi nanti.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Booking status: ${widget.booking.status}'); // Debugging: Memeriksa status booking

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: _navigateToBookingDetail,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar Kursus
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        course!.fullGambarUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, color: Colors.grey[600]),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    // Detail Kursus
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul Kursus
                          Text(
                            course!.nama,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          // Instruktur
                          Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  instruktur!.fullImageUrl,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 30,
                                      height: 30,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.person,
                                          color: Colors.grey[600]),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  instruktur!.nama,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          // Status dan Pesan Peringatan
                          Row(
                            children: [
                              Text(
                                widget.booking.status,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: widget.booking.status == 'Pending'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              if (widget.booking.status == 'Pending') ...[
                                SizedBox(width: 5),
                                Icon(Icons.warning,
                                    color: Colors.red, size: 16),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Segera upload bukti pembayaran',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
