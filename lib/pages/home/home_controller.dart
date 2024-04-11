import 'package:medicine_mark_app/services/shared_local_storage.dart';

class HomePageController {
  List<String> medicines = [];
  var localData = SharedLocalStorageService();
  get medicineLength => medicines.length;

  addMedicine(String medicine) {
    medicines.add(medicine);
    localData.set('medicines', medicines);
  }

  removeMedicine(int index) {
    medicines.removeAt(index);
    localData.set('medicines', medicines);
  }

  loadMedicines() async {
    medicines = await localData.getMeds('medicines') ?? [];
  }

  medicineName(int index) {
    return medicines[index];
  }

  // medicineLength() {
  //   return _medicines.length;
  // }
}
