import 'package:cabin_booking/model/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class BookingCard extends StatelessWidget {
  final Booking booking;

  BookingCard({@required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => {},
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(booking.studentName),
              Text(
                DateFormat('HH:mm').format(booking.dateStart),
                style: TextStyle(color: Colors.black38),
              )
            ],
          ),
        ),
      ),
    );
  }
}
