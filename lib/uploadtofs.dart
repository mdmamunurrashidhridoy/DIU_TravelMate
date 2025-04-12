import 'package:cloud_firestore/cloud_firestore.dart';

final Map<String, dynamic> busSchedules = {
  "route001": {
    "busname": "Surjomukhi-26",
    "from": "Daffodil Smart City",
    "to": "Dhanmondi",
    "time": "03:00 AM",
  },
  "route002": {
    "busname": "Surjomukhi-21",
    "from": "Green Model Town-Mugdha Model Thana-Malibag",
    "to": "Daffodil Smart City",
    "time": "06:20 AM",
  },
  "route003": {
    "busname": "Dolphin-2",
    "from": "Green Model Town-Mugdha Model Thana-Malibag",
    "to": "Daffodil Smart City",
    "time": "06:20 AM",
  },
  "route004": {
    "busname": "Dolphin-7",
    "from": "Green Model Town-Mugdha Model Thana-Malibag",
    "to": "Daffodil Smart City",
    "time": "06:20 AM",
  },
  "route005": {
    "busname": "Surjomukhi-24",
    "from": "Narayanganj Chasara",
    "to": "Daffodil Smart City",
    "time": "06:20 AM",
  },
  "route006": {
    "busname": "Dolphin-27",
    "from": "Narayanganj Chasara",
    "to": "Daffodil Smart City",
    "time": "06:20 AM",
  },
  "route007": {
    "busname": "Rojonigondha-5",
    "from": "Baipal",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route008": {
    "busname": "Surjomukhi-9",
    "from": "Baipal",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route009": {
    "busname": "Surjomukhi-27",
    "from": "Dhamrai Bus Stand",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route010": {
    "busname": "Rojonigondha-3",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route011": {
    "busname": "Rojonigondha-6",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route012": {
    "busname": "Rojonigondha-12",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route013": {
    "busname": "Rojonigondha-13",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route014": {
    "busname": "Dolphin-12",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route015": {
    "busname": "Dolphin-16",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route016": {
    "busname": "Dolphin-17",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route017": {
    "busname": "Dolphin-18",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route018": {
    "busname": "Dolphin-19",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route019": {
    "busname": "Dolphin-20",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route020": {
    "busname": "Dolphin-21",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route021": {
    "busname": "Dolphin-22",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route022": {
    "busname": "Dolphin-25",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route023": {
    "busname": "Dolphin-30",
    "from": "Dhanmondi",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route024": {
    "busname": "Surjomukhi-20",
    "from": "Dhanmondi (Female students)",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route025": {
    "busname": "Rojonigondha-8",
    "from": "ECB",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route026": {
    "busname": "Dolphin-3",
    "from": "ECB",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route027": {
    "busname": "Dolphin-4",
    "from": "ECB",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route028": {
    "busname": "Dolphin-8",
    "from": "ECB",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route029": {
    "busname": "Dolphin-9",
    "from": "ECB",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route030": {
    "busname": "Surjomukhi-14",
    "from": "Konabari Pukur Par",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route031": {
    "busname": "Rojonigondha-9",
    "from": "Mirpur",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route032": {
    "busname": "Surjomukhi-15",
    "from": "Mirpur-1",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route033": {
    "busname": "Surjomukhi-6",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route034": {
    "busname": "Surjomukhi-26",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route035": {
    "busname": "Dolphin-6",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route036": {
    "busname": "Dolphin-24",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route037": {
    "busname": "Dolphin-10",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route038": {
    "busname": "Dolphin-23",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route039": {
    "busname": "Dolphin-22",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route040": {
    "busname": "Dolphin-26",
    "from": "Mirpur-1, Sony Cinema Hall",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route041": {
    "busname": "Surjomukhi-4",
    "from": "Mirpur-10",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route042": {
    "busname": "Dolphin-5",
    "from": "Mirpur-10",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
  "route043": {
    "busname": "Rojonigondha-1",
    "from": "Mirpur-14",
    "to": "Daffodil Smart City",
    "time": "07:00 AM",
  },
};

Future<void> uploadBusSchedules() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference scheduleRef = firestore.collection('bus_schedules');

  for (var entry in busSchedules.entries) {
    await scheduleRef.doc(entry.key).set({
      'busname': entry.value['busname'],
      'from': entry.value['from'],
      'to': entry.value['to'],
      'time': entry.value['time'],
      'routeId': entry.key, // include routeId for reference
    });
  }

  print('✅ All bus schedules uploaded successfully.');
}
