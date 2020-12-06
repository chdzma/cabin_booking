import 'package:cabin_booking/constants.dart';
import 'package:cabin_booking/model/booking.dart';
import 'package:cabin_booking/model/cabin_manager.dart';
import 'package:cabin_booking/model/day_handler.dart';
import 'package:cabin_booking/model/recurring_booking.dart';
import 'package:cabin_booking/utils/show_booking_dialog.dart';
import 'package:cabin_booking/widgets/custom/floating_action_button/floating_action_button_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BookingFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<DayHandler, CabinManager>(
      builder: (context, dayHandler, cabinManager, child) {
        final appLocalizations = AppLocalizations.of(context);

        return FloatingActionButtonMenu(
          animatedIcon: AnimatedIcons.add_event,
          animatedIconTheme: IconThemeData(size: 25.0),
          label: appLocalizations.booking,
          onPressed: () {
            showNewBookingDialog(
              context,
              Booking(
                date: dayHandler.dateTime,
                timeStart: timeTableStartTime,
                timeEnd: timeTableStartTime.replacing(
                  hour: timeTableStartTime.hour + 1,
                ),
                cabinId: cabinManager.cabins.first.id,
              ),
              cabinManager,
            );
          },
          children: [
            FloatingActionButtonMenuChild(
              icon: Icons.repeat,
              label: appLocalizations.recurringBooking,
              onTap: () {
                showNewBookingDialog(
                  context,
                  RecurringBooking(
                    date: dayHandler.dateTime,
                    timeStart: timeTableStartTime,
                    timeEnd: timeTableStartTime.replacing(
                      hour: timeTableStartTime.hour + 1,
                    ),
                    occurrences: 1,
                    cabinId: cabinManager.cabins.first.id,
                  ),
                  cabinManager,
                );
              },
            ),
            FloatingActionButtonMenuChild(
              icon: Icons.lock,
              label: appLocalizations.lockedRange,
              onTap: () {
                showNewBookingDialog(
                  context,
                  Booking(
                    date: dayHandler.dateTime,
                    timeStart: timeTableStartTime,
                    timeEnd: timeTableStartTime.replacing(
                      hour: timeTableStartTime.hour + 1,
                    ),
                    isDisabled: true,
                    cabinId: cabinManager.cabins.first.id,
                  ),
                  cabinManager,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
