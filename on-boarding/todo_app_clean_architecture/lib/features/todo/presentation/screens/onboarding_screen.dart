import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 164, 49, 180).withOpacity(0.7)),
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
                    Navigator.pushNamed(context, '/tasks');
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
