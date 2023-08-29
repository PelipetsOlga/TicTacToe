import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Home'),
            OutlinedButton(
                onPressed: () => context.push('/game'),
                child: const Text('Run')),
            OutlinedButton(
                onPressed: () => context.push('/settings'),
                child: const Text('Settings')),
            OutlinedButton(onPressed: () => exit(0), child: const Text('Exit')),
          ],
        ),
      ),
    );
  }
}
