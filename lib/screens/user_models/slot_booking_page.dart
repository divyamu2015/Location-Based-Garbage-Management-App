import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WastePickupScheduler extends StatefulWidget {
  const WastePickupScheduler({super.key});

  @override
  State<WastePickupScheduler> createState() => _WastePickupSchedulerState();
}

class _WastePickupSchedulerState extends State<WastePickupScheduler> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String? _selectedTimeSlot;
  // List<String> _timeSlots = ["8:00 AM - 10:00 AM", "10:00 AM - 12:00 PM", "2:00 PM - 4:00 PM"];
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  void _submitPickupRequest() async {
    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a time slot")));
      return;
    }

    final url = Uri.parse(
        "https://417sptdw-8002.inc1.devtunnels.ms/userapp/waste_submission/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "date": selectedDate.toIso8601String().split("T")[0],
        "time_slot": _selectedTimeSlot,
      }),
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pickup scheduled successfully!")));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to schedule pickup")));
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule Waste Pickup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDate,
              firstDay: DateTime.now(),
              lastDay: DateTime(2100),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                });
              },
            ),
            const SizedBox(height: 10),
            Text("Selected Time: ${selectedTime.format(context)}"),
            ElevatedButton(
              onPressed: () => selectTime(context),
              child: const Text("Pick a Time"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               
              },
              // _submitPickupRequest,
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
