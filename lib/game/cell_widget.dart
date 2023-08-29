import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../logic/models.dart';

class CellWidget extends StatelessWidget {
  TicTacSymbol symbol;
  VoidCallback callback;
  bool isWinner;

  CellWidget(this.symbol, this.callback, this.isWinner, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget iconData;
    if (symbol == TicTacSymbol.cross) {
      iconData = svg1;
    } else if (symbol == TicTacSymbol.oval) {
      iconData = svg2;
    } else {
      iconData = const SizedBox(width: 88, height: 88);
    }

    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: 88,
          height: 88,
          color: isWinner ? Colors.amberAccent : Colors.transparent,
          child: iconData,
        ),
      ),
    );
  }
}

const String assetName1 = 'assets/dog_ic.svg';
const String assetName2 = 'assets/rain.svg';
final Widget svg1 = Padding(
  padding: const EdgeInsets.all(8.0),
  child:   SvgPicture.asset(
    assetName1,
    semanticsLabel: 'Cross',
    width: 48,
    height: 48,
  ),
);
final Widget svg2 = Padding(
  padding: const EdgeInsets.all(8.0),
  child:   SvgPicture.asset(
    assetName2,
    semanticsLabel: 'Zero',
    width: 48,
    height: 48,
  ),
);
