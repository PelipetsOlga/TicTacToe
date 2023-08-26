import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class SettingsWidget extends StatelessWidget{
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Settings'),
        OutlinedButton(onPressed: () => context.go(getBackLink()), child: Text('Back')),
      ],
    );
  }

  String getBackLink();
}