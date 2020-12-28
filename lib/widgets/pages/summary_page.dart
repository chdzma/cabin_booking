import 'package:cabin_booking/model/cabin_manager.dart';
import 'package:cabin_booking/utils/colors.dart';
import 'package:cabin_booking/widgets/layout/statistics.dart';
import 'package:cabin_booking/widgets/standalone/heatmap_calendar/heatmap_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Consumer<CabinManager>(
        builder: (builder, cabinManager, child) {
          return Column(
            children: [
              Row(
                children: [
                  Statistics(
                    title: appLocalizations.cabins,
                    items: [
                      StatisticItem(value: '${cabinManager.cabins.length}'),
                    ],
                  ),
                  const SizedBox(width: 32.0),
                  Statistics(
                    title: appLocalizations.bookings,
                    items: [
                      StatisticItem(
                        label: appLocalizations.total,
                        value: '${cabinManager.allBookingsCount}',
                      ),
                      StatisticItem(
                        label: appLocalizations.bookings,
                        value: '${cabinManager.bookingsCount}',
                      ),
                      StatisticItem(
                        label: appLocalizations.recurringBookings,
                        value: '${cabinManager.recurringBookingsCount}',
                      ),
                    ],
                  ),
                  const SizedBox(width: 32.0),
                  Statistics(
                    title: appLocalizations.mostBookedDay,
                    items: [
                      StatisticItem(
                        value: DateFormat.yMMMd().format(
                          cabinManager.mostBookedDayEntry.key,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: HeatMapCalendar(
                      input: cabinManager.allCabinsBookingsCountPerDay,
                      colorThresholds: mapColorsToHighestValue(
                        highestValue: cabinManager.mostBookedDayEntry.value,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}