import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:sahsiyet/src/core/services/prayer_times_service.dart';

class DashboardState {
  final DateTime currentDate;
  final HijriCalendar currentHijriDate;
  final List<PrayerTime> prayerTimes;
  final PrayerTime? nextPrayer;
  final Duration? timeUntilNextPrayer;
  final bool isLoadingPrayers;

  DashboardState({
    required this.currentDate,
    required this.currentHijriDate,
    this.prayerTimes = const [],
    this.nextPrayer,
    this.timeUntilNextPrayer,
    this.isLoadingPrayers = false,
  });

  String get formattedDate => DateFormat('d MMMM yyyy, EEEE', 'tr_TR').format(currentDate);
  String get formattedHijriDate => '${currentHijriDate.hDay} ${currentHijriDate.longMonthName} ${currentHijriDate.hYear}';

  DashboardState copyWith({
    DateTime? currentDate,
    HijriCalendar? currentHijriDate,
    List<PrayerTime>? prayerTimes,
    PrayerTime? nextPrayer,
    Duration? timeUntilNextPrayer,
    bool? isLoadingPrayers,
  }) {
    return DashboardState(
      currentDate: currentDate ?? this.currentDate,
      currentHijriDate: currentHijriDate ?? this.currentHijriDate,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      timeUntilNextPrayer: timeUntilNextPrayer ?? this.timeUntilNextPrayer,
      isLoadingPrayers: isLoadingPrayers ?? this.isLoadingPrayers,
    );
  }
}

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController()
      : super(DashboardState(
          currentDate: DateTime.now(),
          currentHijriDate: HijriCalendar.now(),
          isLoadingPrayers: true,
        )) {
      HijriCalendar.setLocal('tr');
      _loadPrayerTimes();
      _startPrayerTimer();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final prayers = await PrayerTimesService.getPrayerTimes();
      final nextPrayer = PrayerTimesService.getNextPrayer(prayers);
      final timeUntil = PrayerTimesService.getTimeUntilNextPrayer(prayers);

      state = state.copyWith(
        prayerTimes: prayers,
        nextPrayer: nextPrayer,
        timeUntilNextPrayer: timeUntil,
        isLoadingPrayers: false,
      );
    } catch (e) {
      print('Error loading prayer times: $e');
      state = state.copyWith(isLoadingPrayers: false);
    }
  }

  void _startPrayerTimer() {
    // Update countdown every minute
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        final timeUntil = PrayerTimesService.getTimeUntilNextPrayer(state.prayerTimes);
        state = state.copyWith(timeUntilNextPrayer: timeUntil);
        _startPrayerTimer();
      }
    });
  }

  Future<void> refreshPrayerTimes() async {
    state = state.copyWith(isLoadingPrayers: true);
    await _loadPrayerTimes();
  }
}

final dashboardControllerProvider = StateNotifierProvider<DashboardController, DashboardState>((ref) {
  return DashboardController();
});
