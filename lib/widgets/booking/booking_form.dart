import 'package:cabin_booking/l10n/app_localizations.dart';
import 'package:cabin_booking/model/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  final Booking booking;

  BookingForm(this.booking);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  final Booking _booking = Booking();

  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  TimeOfDay _startTime;
  TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();

    _startTime = TimeOfDay.fromDateTime(widget.booking.dateStart);
    _endTime = TimeOfDay.fromDateTime(widget.booking.dateEnd);
  }

  DateTime _tryTimeParse(String value) {
    return DateTime.tryParse(
      DateFormat('yyyy-MM-dd').format(widget.booking.dateStart) + ' $value',
    );
  }

  @override
  Widget build(BuildContext context) {
    _startTimeController.text = _startTime.format(context);
    _endTimeController.text = _endTime.format(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.booking.studentName,
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String value) {
              if (value.isEmpty)
                return AppLocalizations.of(context).enterStudentName;

              return null;
            },
            onSaved: (value) {
              _booking.studentName = value;
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).student,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _startTimeController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              final _parsedTime = _tryTimeParse(value);

              if (value.isEmpty || _parsedTime == null)
                return AppLocalizations.of(context).enterStartTime;

              if (_parsedTime.compareTo(
                    _tryTimeParse(_endTime.format(context)),
                  ) >
                  0) return AppLocalizations.of(context).enterValidRange;

              return null;
            },
            onTap: () async {
              final _time = await showTimePicker(
                context: context,
                initialTime: _startTime,
              );

              if (_time != null)
                setState(() {
                  _startTime = _time;
                  _startTimeController.text = _time.format(context);
                });
            },
            onSaved: (value) {
              _booking.dateStart = DateTime.parse(
                DateFormat('yyyy-MM-dd').format(widget.booking.dateStart) +
                    ' $value',
              );
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).start,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.schedule),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _endTimeController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              final _parsedTime = _tryTimeParse(value);

              if (value.isEmpty || _parsedTime == null)
                return AppLocalizations.of(context).enterEndTime;

              if (_parsedTime.compareTo(
                    _tryTimeParse(_startTime.format(context)),
                  ) <
                  0) return AppLocalizations.of(context).enterValidRange;

              return null;
            },
            onTap: () async {
              final _time = await showTimePicker(
                context: context,
                initialTime: _endTime,
              );

              if (_time != null)
                setState(() {
                  _endTime = _time;
                  _endTimeController.text = _time.format(context);
                });
            },
            onSaved: (value) {
              _booking.dateEnd = DateTime.parse(
                DateFormat('yyyy-MM-dd').format(widget.booking.dateEnd) +
                    ' $value',
              );
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).end,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.schedule),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                if (widget.booking.id != null) _booking.id = widget.booking.id;

                Navigator.of(context).pop<Booking>(_booking);
              }
            },
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context).book.toUpperCase()),
          )
        ],
      ),
    );
  }
}
