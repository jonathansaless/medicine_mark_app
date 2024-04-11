import 'package:flutter/material.dart';
import 'package:medicine_mark_app/pages/medicine/medicine_controller.dart';

class MedicineDetailsPage extends StatefulWidget {
  final String medicine;

  MedicineDetailsPage({required this.medicine});

  @override
  _MedicineDetailsPageState createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  final _controller = MedicineController();

  bool get _takeTheMedicine => _controller.takeTheMedicine;

  @override
  void initState() {
    super.initState();
    // ValueNotifier sem usar Builders. Isto é, a cada mudança a tela será renderizada por inteira.
    _controller.takeTheMedicine$.addListener(() {
      setState(() {});
    });
    _controller.loadMedicineStatus(widget.medicine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _takeTheMedicine == true ? Colors.green : Colors.red,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _takeTheMedicine == true
                  ? Text(
                      'Você já tomou ${widget.medicine} hoje.',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'Você ainda não tomou ${widget.medicine} hoje.',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
              SizedBox(
                height: 20,
              ),
              _takeTheMedicine == true
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 100.0,
                    )
                  : ElevatedButton(
                      onPressed: () {
                        _controller.medicineTaken(widget.medicine);
                      },
                      child: Text('Tomar!'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.all(20)),
                    )
            ],
          ),
        ));
  }

  Widget buildDayWidget(DateTime date, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          date.day.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
