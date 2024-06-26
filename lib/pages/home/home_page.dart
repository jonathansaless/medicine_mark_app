import 'package:flutter/material.dart';
import 'package:medicine_mark_app/pages/home/home_controller.dart';
import 'package:medicine_mark_app/pages/medicine/medicine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomePageController();

  List<String> get _medicines => _controller.medicines;

  TextEditingController medicineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.medicines$.addListener(() {
      setState(() {});
    });
    _controller.loadMedicines();
    _controller
        .checkMedicineStatus(); // Verifica o status dos remédios diariamente
  }

  void confirmRemoveMedicine(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remover ${_controller.medicine(index)}'),
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
                _controller.removeMedicine(index);
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
        itemCount: _controller.medicineLength,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_controller.medicine(index)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicineDetailsPage(
                      medicine: _controller.medicine(index)),
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
                      _controller.addMedicine(medicineController.text);
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
