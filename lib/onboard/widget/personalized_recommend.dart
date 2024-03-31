import 'package:flutter/material.dart';

class PersonalizRec extends StatelessWidget {
  const PersonalizRec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/personal.png', height: 300),
              const SizedBox(height: 20),
              const Text('Personalized Recommendations',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              const Text(
                  'Receive personalized song suggestions based on your listening history and preferences. Let Meens be your guide to discovering music you\'ll love.',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
