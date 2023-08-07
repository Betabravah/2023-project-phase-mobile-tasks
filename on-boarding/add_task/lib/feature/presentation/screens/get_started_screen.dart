import 'package:add_task/feature/presentation/screens/add_task_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        home: Scaffold(
            body: Stack(children: [
      Container(
        decoration: BoxDecoration(color: primaryColor.withOpacity(0.7)),
      ),
      const Center(
          child: Image(
        image: AssetImage('assets/images/splash_screen.png'),
      )),
      Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
                width: 230,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  child: const Text("Get Started"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addtask');
                  },
                )),
          ))
    ])));
  }
}
