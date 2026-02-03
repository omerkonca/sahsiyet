import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PrayerTime {
  final String name;
  final DateTime time;
  final String displayName;

  PrayerTime({
    required this.name,
    required this.time,
    required this.displayName,
  });
}

class PrayerTimesService {
  static const String _baseUrl = 'http://api.aladhan.com/v1';

  // Get prayer times for current location
  static Future<List<PrayerTime>> getPrayerTimes() async {
    try {
      // Get location
      final position = await _getCurrentLocation();
      
      // Get prayer times from API
      final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final url = '$_baseUrl/timings/$date?latitude=${position.latitude}&longitude=${position.longitude}&method=13'; // method=13 is Turkey
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'] as Map<String, dynamic>;
        
        return _parsePrayerTimes(timings);
      } else {
        throw Exception('API hatası: ${response.statusCode}');
      }
    } catch (e) {
      print('Prayer Times Error: $e');
      // Return mock data for development
      return _getMockPrayerTimes();
    }
  }

  static Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Konum servisleri kapalı');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Konum izni reddedildi');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Konum izni kalıcı olarak reddedildi');
    }

    return await Geolocator.getCurrentPosition();
  }

  static List<PrayerTime> _parsePrayerTimes(Map<String, dynamic> timings) {
    final now = DateTime.now();
    final dateFormat = DateFormat('HH:mm');
    
    final prayers = [
      {'name': 'Fajr', 'displayName': 'İmsak', 'time': timings['Fajr']},
      {'name': 'Sunrise', 'displayName': 'Güneş', 'time': timings['Sunrise']},
      {'name': 'Dhuhr', 'displayName': 'Öğle', 'time': timings['Dhuhr']},
      {'name': 'Asr', 'displayName': 'İkindi', 'time': timings['Asr']},
      {'name': 'Maghrib', 'displayName': 'Akşam', 'time': timings['Maghrib']},
      {'name': 'Isha', 'displayName': 'Yatsı', 'time': timings['Isha']},
    ];

    return prayers.map((prayer) {
      final timeStr = prayer['time'] as String;
      final timeParts = timeStr.split(':');
      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );

      return PrayerTime(
        name: prayer['name'] as String,
        displayName: prayer['displayName'] as String,
        time: prayerTime,
      );
    }).toList();
  }

  static List<PrayerTime> _getMockPrayerTimes() {
    final now = DateTime.now();
    
    return [
      PrayerTime(
        name: 'Fajr',
        displayName: 'İmsak',
        time: DateTime(now.year, now.month, now.day, 5, 45),
      ),
      PrayerTime(
        name: 'Sunrise',
        displayName: 'Güneş',
        time: DateTime(now.year, now.month, now.day, 7, 15),
      ),
      PrayerTime(
        name: 'Dhuhr',
        displayName: 'Öğle',
        time: DateTime(now.year, now.month, now.day, 12, 30),
      ),
      PrayerTime(
        name: 'Asr',
        displayName: 'İkindi',
        time: DateTime(now.year, now.month, now.day, 15, 15),
      ),
      PrayerTime(
        name: 'Maghrib',
        displayName: 'Akşam',
        time: DateTime(now.year, now.month, now.day, 17, 45),
      ),
      PrayerTime(
        name: 'Isha',
        displayName: 'Yatsı',
        time: DateTime(now.year, now.month, now.day, 19, 15),
      ),
    ];
  }

  // Get next prayer
  static PrayerTime? getNextPrayer(List<PrayerTime> prayerTimes) {
    final now = DateTime.now();
    
    for (final prayer in prayerTimes) {
      if (prayer.time.isAfter(now)) {
        return prayer;
      }
    }
    
    // If no prayer found, return first prayer of next day
    return prayerTimes.isNotEmpty ? prayerTimes.first : null;
  }

  // Get time remaining until next prayer
  static Duration? getTimeUntilNextPrayer(List<PrayerTime> prayerTimes) {
    final nextPrayer = getNextPrayer(prayerTimes);
    if (nextPrayer == null) return null;
    
    return nextPrayer.time.difference(DateTime.now());
  }
}
