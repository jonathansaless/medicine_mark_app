import 'package:flutter/material.dart';
import 'package:medicine_mark_app/medicine_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembrete de Remédios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MedicineList(),
    );
  }
}

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<String> medicines = [];
  TextEditingController medicineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  void loadMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      medicines = prefs.getStringList('medicines') ?? [];
    });
  }

  void addMedicine(String medicine) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      medicines.add(medicine);
      prefs.setStringList('medicines', medicines);
    });
  }

  void removeMedicine(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      medicines.removeAt(index);
      prefs.setStringList('medicines', medicines);
    });
  }

  void confirmRemoveMedicine(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remover Remédio'),
          content: Text('Deseja realmente remover este remédio?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remover'),
              onPressed: () {
                removeMedicine(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lembrete de Remédios'),
      ),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return ListTile(
  title: Text(medicines[index]),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineDetailsPage(medicine: medicines[index]),
      ),
    );
  },
  trailing: IconButton(
    icon: Icon(Icons.close),
    onPressed: () {
      confirmRemoveMedicine(index);
    },
  ),
);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Adicionar Remédio'),
                content: TextField(
                  controller: medicineController,
                  decoration: InputDecoration(hintText: 'Nome do remédio'),
                ),
                actions: [
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Adicionar'),
                    onPressed: () {
                      addMedicine(medicineController.text);
                      medicineController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
