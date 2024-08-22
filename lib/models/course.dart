import 'package:intl/intl.dart';

class Instruktur {
  final int id;
  final String nama;
  final String email;
  final String noHp;
  final String alamat;
  final String image;

  Instruktur({
    required this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.alamat,
    required this.image,
  });

  factory Instruktur.fromJson(Map<String, dynamic> json) {
    return Instruktur(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      noHp: json['no_hp'],
      alamat: json['alamat'],
      image: json['image'],
    );
  }

  String get fullImageUrl => 'http://192.168.100.151:8000/$image';
  // String get fullImageUrl => 'http://127.0.0.1:8000/$image';
}

class Course {
  final int id;
  final String nama;
  final String deskripsi;
  final int jamPelajaran;
  final String language;
  final DateTime startCourse;
  final int jumlahPertemuan;
  final int kapasitas;
  final int harga;
   final String rating;
  final String gambar;
  final int instrukturId;
  final int categoryId;
  final Instruktur instruktur;

  Course({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.jamPelajaran,
    required this.language,
    required this.startCourse,
    required this.jumlahPertemuan,
    required this.kapasitas,
    required this.harga,
    required this.rating,
    required this.gambar,
    required this.instrukturId,
    required this.categoryId,
    required this.instruktur,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      jamPelajaran: json['jam_pelajaran'],
      language: json['language'],
      startCourse: DateTime.parse(json['start_course']),
      jumlahPertemuan: json['jumlah_pertemuan'],
      kapasitas: json['kapasitas'],
      harga: json['harga'],
      rating: json['rating'] ?? '0',
      gambar: json['gambar'],
      instrukturId: json['instruktur_id'],
      categoryId: json['category_id'],
      instruktur: Instruktur.fromJson(json['instruktur']),
    );
  }

  String get formattedStartCourse {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(startCourse);
  }

  // String get fullGambarUrl => 'http://127.0.0.1:8000/$gambar';
  String get fullGambarUrl => 'http://192.168.100.151:8000/$gambar';

}
