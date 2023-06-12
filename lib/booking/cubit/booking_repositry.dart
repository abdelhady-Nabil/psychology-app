import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psychology_app/booking/cubit/booking_model.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Booking>> fetchBookings() async {
    final querySnapshot = await _firestore.collection('bookings').get();
    final bookings = querySnapshot.docs.map((doc) => Booking.fromDocument(doc)).toList();
    return bookings;
  }

// Implement other database operations such as creating bookings, updating data, etc.
}
