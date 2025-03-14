import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tarvel_mate/pages/design_tm.dart';


class TimeSchedule extends StatefulWidget {
  const TimeSchedule({super.key});

  @override
  State<TimeSchedule> createState() => _TimeScheduleState();
}

class _TimeScheduleState extends State<TimeSchedule> {
  List schedule = [
    Schedule(busname: "Surjomukhi-26", from: "Daffodil Smart City", to: "Dhanmondi", time: "03:00 AM"),
    Schedule(busname: "Surjomukhi-21", from: "Green Model Town-Mugdha Model Thana-Malibag", to: "Daffodil Smart City", time: "06:20 AM"),
    Schedule(busname: "Dolphin-2", from: "Green Model Town-Mugdha Model Thana-Malibag", to: "Daffodil Smart City", time: "06:20 AM"),
    Schedule(busname: "Dolphin-7", from: "Green Model Town-Mugdha Model Thana-Malibag", to: "Daffodil Smart City", time: "06:20 AM"),
    Schedule(busname: "Surjomukhi-24", from: "Narayanganj Chasara", to: "Daffodil Smart City", time: "06:20 AM"),
    Schedule(busname: "Dolphin-27", from: "Narayanganj Chasara", to: "Daffodil Smart City", time: "06:20 AM"),
    Schedule(busname: "Rojonigondha-5", from: "Baipal", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-9", from: "Baipal", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-27", from: "Dhamrai Bus Stand", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-3", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-6", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-12", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-13", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-12", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-16", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-17", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-18", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-19", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-20", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-21", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-22", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-25", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-30", from: "Dhanmondi", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-20", from: "Dhanmondi (Female students)", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-8", from: "ECB", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-3", from: "ECB", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-4", from: "ECB", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-8", from: "ECB", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-9", from: "ECB", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-14", from: "Konabari Pukur Par", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-9", from: "Mirpur", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-15", from: "Mirpur-1", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-6", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-26", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-6", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-24", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-10", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-23", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-22", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-26", from: "Mirpur-1, Sony Cinema Hall", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Surjomukhi-4", from: "Mirpur-10", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Dolphin-5", from: "Mirpur-10", to: "Daffodil Smart City", time: "07:00 AM"),
    Schedule(busname: "Rojonigondha-1", from: "Mirpur-14", to: "Daffodil Smart City", time: "07:00 AM"),
  ];


  Widget scheduleTemplate(schedule) {
    return ScheduleCard(schedule: schedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppbarTop(),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children:
              schedule.map((quote) => ScheduleCard(schedule: quote)).toList(),
        ),
      ),
    );
  }
}

@immutable
class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const ScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shadowColor: const Color.fromARGB(255, 224, 218, 218),
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        key: ValueKey(schedule.busname),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                " ${schedule.busname ?? 'No text available'}",
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSans',
                ),
              ),
            ),

            SizedBox(height: 6.0),
            Text(
              "From :  ${schedule.from ?? 'Unknown'}",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'DMSans',
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              "To       :  ${schedule.to ?? 'Unknown'}",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'DMSans',
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              "Time  :  ${schedule.time ?? 'Unknown'}",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'DMSans',
              ),
            ),
            SizedBox(height: 4.0),

            TextButton.icon(
              onPressed: () {
                //Navigator.pushNamed(context, '/login');
              },
              icon: Icon(Iconsax.bus_outline, color: const Color.fromARGB(255, 0, 0, 0)),
              label: Text(
                'Book Now',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'DMSans',
                  fontSize: 18,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.transparent,
                ), // No background color
                overlayColor: MaterialStateProperty.all(
                  Colors.transparent,
                ), // Removes click effect
                splashFactory: NoSplash.splashFactory, // Disables ripple effect
              ),
            ),
          ],
        ),
      ),
    );
  }
}
