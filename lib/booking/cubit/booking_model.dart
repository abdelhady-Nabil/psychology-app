import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;

  Booking({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  factory Booking.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Booking(
      id: doc.id,
      title: data['title'] as String,
      startDate: (data['start_date'] as Timestamp).toDate(),
      endDate: (data['end_date'] as Timestamp).toDate(),
    );
  }
}
