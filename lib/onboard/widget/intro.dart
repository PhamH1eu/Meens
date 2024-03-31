import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/intro.png', height: 300),
              const SizedBox(height: 20),
              const Text('Discover New Music',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              const Text(
                  'Explore a vast library of songs curated just for you. From trending hits to hidden gems, find your next favorite tune effortlessly',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
