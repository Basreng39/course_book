class Booking {
  final int id;
  final int userId;
  final int courseId;
  final int instrukturId;
  late final String status;
  late final String? buktiTransfer;

  Booking({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.instrukturId,
    required this.status,
    this.buktiTransfer,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      courseId: json['course_id'],
      instrukturId: json['instruktur_id'],
      status: json['status'],
      buktiTransfer: json['bukti_transfer'],
    );
  }

  get course => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'course_id': courseId,
      'instruktur_id': instrukturId,
      'status': status,
      'bukti_transfer': buktiTransfer,
    };
  }
}
