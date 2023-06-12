import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychology_app/booking/cubit/state.dart';

import 'booking_repositry.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _bookingRepository;

  BookingCubit(this._bookingRepository) : super(BookingInitial());

  Future<void> fetchBookings() async {
    try {
      emit(BookingLoading());
      final bookings = await _bookingRepository.fetchBookings();
      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError('Failed to fetch bookings.'));
    }
  }
}