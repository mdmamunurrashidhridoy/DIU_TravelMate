class Booking {
  final String userId; // You'll need to get this from your auth system
  final String routeId;
  final String busname;
  final String from;
  final String to;
  final String time;
  final DateTime bookingTime;
  final String status; // "confirmed", "cancelled", etc.

  Booking({
    required this.userId,
    required this.routeId,
    required this.busname,
    required this.from,
    required this.to,
    required this.time,
    required this.bookingTime,
    this.status = "confirmed",
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'routeId': routeId,
      'busname': busname,
      'from': from,
      'to': to,
      'time': time,
      'bookingTime': bookingTime.toIso8601String(),
      'status': status,
    };
  }
}