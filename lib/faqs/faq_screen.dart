import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utilities/provider.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.watch(countProvider.notifier).state = 0;
              },
            ),
            title: const Text('FAQ'),
          ),
          body: const Center(
            child: Text('FAQ'),
          ),
        );
      },
    );
  }
}
