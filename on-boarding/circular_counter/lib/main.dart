import 'package:flutter/material.dart';

void main() {
  runApp(CircularCounter());
}

class CircularCounter extends StatefulWidget {
  @override
  _CircularCounterState createState() => _CircularCounterState();
}

class _CircularCounterState extends State<CircularCounter> {
  double counter = 0;

  void incrementCounter() {
    setState(() {
      counter = (counter + 1) % 11;
    });
  }

  void decrementCounter() {
    setState(() {
      counter = (counter - 1) % 11;
      if (counter < 0) counter = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Circular Counter'),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      '${(counter).toInt()}',
                      style: const TextStyle(
                        fontSize: 70,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: 150,
                      child: MaterialButton(
                        onPressed: incrementCounter,
                        child: Text("Increment"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110.0),
                      ),
                      width: 150,
                      child: MaterialButton(
                        onPressed: decrementCounter,
                        child: const Text("Decrement"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )));
  }
}
