import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tarvel_mate/pages/design_tm.dart';

class Schedule {
  final String? busname;
  final String? from;
  final String? to;
  final String? time;
  final String routeId;

  Schedule({
    required this.busname,
    required this.from,
    required this.to,
    required this.time,
    required this.routeId,
  });

  factory Schedule.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Schedule(
      busname: data['busname'],
      from: data['from'],
      to: data['to'],
      time: data['time'],
      routeId: data['routeId'] ?? doc.id, // Use document ID as fallback
    );
  }
}

class TimeSchedule extends StatefulWidget {
  const TimeSchedule({super.key});

  @override
  State<TimeSchedule> createState() => _TimeScheduleState();
}

class _TimeScheduleState extends State<TimeSchedule> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Schedule> allSchedules = [];
  List<Schedule> filteredSchedules = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSchedules();
  }

  Future<void> _fetchSchedules() async {
    try {
      final querySnapshot = await _firestore.collection('schedules').get();
      
      setState(() {
        allSchedules = querySnapshot.docs.map((doc) => Schedule.fromFirestore(doc)).toList();
        filteredSchedules = List.from(allSchedules);
        _isLoading = false;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load schedules. Please try again later.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _filterSchedules(String searchTerm) {
    if (searchTerm.isEmpty) {
      setState(() {
        filteredSchedules = List.from(allSchedules);
      });
      return;
    }

    final term = searchTerm.toLowerCase();
    setState(() {
      filteredSchedules = allSchedules.where((schedule) {
        return (schedule.busname?.toLowerCase().contains(term) ?? false) ||
               (schedule.from?.toLowerCase().contains(term) ?? false) ||
               (schedule.to?.toLowerCase().contains(term) ?? false);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Schedules'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(32.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search by bus, from, or to',
                            prefixIcon: const Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                          onChanged: _filterSchedules,
                        ),
                      ),
                    ),
                    Expanded(
                      child: filteredSchedules.isEmpty
                          ? const Center(child: Text('No schedules found'))
                          : ListView.builder(
                              itemCount: filteredSchedules.length,
                              itemBuilder: (context, index) {
                                final schedule = filteredSchedules[index];
                                return ScheduleCard(schedule: schedule);
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  
  const ScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schedule.busname ?? 'Unknown Bus',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'From: ${schedule.from ?? 'Unknown location'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'To: ${schedule.to ?? 'Unknown location'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Time: ${schedule.time ?? 'Unknown time'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // Handle booking
                },
                icon: const Icon(Icons.directions_bus),
                label: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}