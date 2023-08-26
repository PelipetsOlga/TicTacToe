import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Home'),
            OutlinedButton(onPressed: () => context.go('/game'), child: Text('Run')),
            OutlinedButton(onPressed: () => context.go('/home_settings'), child: Text('Settings')),
            OutlinedButton(onPressed: ()=> exit(0), child: Text('Exit')),
          ],
        ),
      ),
    );
  }
}