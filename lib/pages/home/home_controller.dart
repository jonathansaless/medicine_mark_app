import 'package:flutter/material.dart';
import 'package:medicine_mark_app/services/shared_local_storage.dart';

class HomePageController {
  var localData = SharedLocalStorageService();
  ValueNotifier<List<String>> medicines$ = ValueNotifier([]);
  get medicineLength => medicines$.value.length;

  List<String> get medicines => medicines$.value;

  addMedicine(String medicine) {
    // Precisei criar uma nova lista e adicionar o remédio a ela
    // em seguida atribui lista para minha lista reativa.
    // Isso se deu pois se apenas adicionasse o remédio direto
    // na lista, não era notificado que a lista mudou sem
    // precisar utilizar o notifyListeners
    List<String> updatedMedicines = List<String>.from(medicines$.value);
    updatedMedicines.add(medicine);
    medicines$.value = updatedMedicines;
    localData.set('medicines', medicines$.value);
  }

  removeMedicine(int index) {
    List<String> updatedMedicines = List<String>.from(medicines$.value);
    updatedMedicines.removeAt(index);
    medicines$.value = updatedMedicines;
    localData.set('medicines', medicines$.value);
  }

  loadMedicines() async {
    medicines$.value = await localData.getMeds('medicines') ?? [];
  }

  medicine(int index) {
    return medicines$.value[index];
  }

  checkMedicineStatus() async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    List<String> updatedMedicines = List<String>.from(medicines$.value);

    for (int i = 0; i < updatedMedicines.length; i++) {
      String key = updatedMedicines[i];
      bool isTaken = await localData.getMed(key) ?? false;

      if (isTaken) {
        DateTime? lastTakenDate = localData.getLastTakenDate(key) as DateTime?;


        if (lastTakenDate!.isBefore(today)) {
          // Remédio tomado antes da meia-noite, atualiza o status para falso
          localData.set(key, false);
        }
      } else {
        // Remédio não tomado, salva a data do último dia antes da meia-noite
        localData.setLastTakenDate(key, today.subtract(Duration(days: 1)));
      }
    }

    loadMedicines(); // Recarrega a lista de remédios após as atualizações
  }
}
