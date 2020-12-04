import 'package:cabin_booking/constants.dart';
import 'package:cabin_booking/model/cabin_manager.dart';
import 'package:cabin_booking/model/day_handler.dart';
import 'package:cabin_booking/widgets/booking/bookings_stack.dart';
import 'package:cabin_booking/widgets/layout/current_time_indicator.dart';
import 'package:cabin_booking/widgets/layout/stripped_background.dart';
import 'package:cabin_booking/widgets/layout/time_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StrippedBackground(
          startTime: timeTableStartTime,
          endTime: timeTableEndTime,
        ),
        Consumer2<DayHandler, CabinManager>(
          builder: (context, dayHandler, cabinManager, child) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child,
                for (final cabin in cabinManager.cabins)
                  SizedBox(
                    width: columnWidth,
                    child: BookingsStack(
                      cabin: cabin.simplified(),
                      bookings: cabin.bookingsOn(dayHandler.dateTime),
                    ),
                  ),
              ],
            );
          },
          child: TimeColumn(),
        ),
        CurrentTimeIndicator(),
      ],
    );
  }
}
