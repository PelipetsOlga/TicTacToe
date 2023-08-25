import 'package:flutter/material.dart';
import 'models.dart';

class CellWidget extends StatelessWidget {
  TicTacSymbol symbol;
  VoidCallback callback;
  bool isWinner;

  CellWidget(this.symbol, this.callback, this.isWinner, {super.key});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    if (symbol == TicTacSymbol.cross) {
      iconData = Icons.close_rounded;
    } else if (symbol == TicTacSymbol.oval) {
      iconData = Icons.circle_outlined;
    } else {
      iconData = Icons.check_box_outline_blank;
    }

    Color iconColor;
    if (symbol == TicTacSymbol.cross) {
      iconColor = Colors.deepPurple;
    } else if (symbol == TicTacSymbol.oval) {
      iconColor = Colors.pinkAccent;
    } else {
      iconColor = Colors.grey;
    }

    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 64,
        height: 64,
        color: isWinner? Colors.amberAccent: Colors.white,
        child: Icon(iconData, color: iconColor),
      ),
    );
  }
}
