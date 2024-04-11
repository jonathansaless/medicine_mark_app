import 'package:flutter/material.dart';
import 'package:medicine_mark_app/services/shared_local_storage.dart';

class MedicineController {
  var localData = SharedLocalStorageService();
  final DateTime _today = DateTime.now();
  ValueNotifier<bool> takeTheMedicine$ = ValueNotifier(false);
  // final Map<DateTime, List<dynamic>> _markedDates = {};
  
  bool get takeTheMedicine => takeTheMedicine$.value;
  get today => _today;

  medicineTaken(String key) {
    takeTheMedicine$.value = true;
    localData.set(key, takeTheMedicine$.value);
  }

  loadMedicineStatus(String key) async {
    takeTheMedicine$.value = await localData.getMed(key) ?? false;
  }
}
