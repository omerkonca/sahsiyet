import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class DashboardState {
  final DateTime currentDate;
  final HijriCalendar currentHijriDate;

  DashboardState({
    required this.currentDate,
    required this.currentHijriDate,
  });

  String get formattedDate => DateFormat('d MMMM yyyy, EEEE', 'tr_TR').format(currentDate);
  String get formattedHijriDate => '${currentHijriDate.hDay} ${currentHijriDate.longMonthName} ${currentHijriDate.hYear}';
}

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController()
      : super(DashboardState(
          currentDate: DateTime.now(),
          currentHijriDate: HijriCalendar.now(),
        )) {
      HijriCalendar.setLocal('tr'); // Hicri takvim Türkçe
      }
}

final dashboardControllerProvider = StateNotifierProvider<DashboardController, DashboardState>((ref) {
  return DashboardController();
});
