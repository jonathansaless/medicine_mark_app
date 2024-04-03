import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineDetailsPage extends StatefulWidget {
  final String medicine;

  MedicineDetailsPage({required this.medicine});

  @override
  _MedicineDetailsPageState createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  DateTime _today = DateTime.now();
  bool? takeTheMedicine = false;
  final Map<DateTime, List<dynamic>> _markedDates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: takeTheMedicine == true ? Colors.green : Colors.red,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              takeTheMedicine == true
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
              takeTheMedicine == false
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          takeTheMedicine = true;
                        });
                      },
                      child: Text('Sinalizar que tomei o remédio hoje!'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(20)),
                    )
                  : ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.done),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
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