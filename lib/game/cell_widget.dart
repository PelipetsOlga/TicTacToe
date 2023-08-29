import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../logic/models.dart';

class CellWidget extends StatelessWidget {
  TicTacSymbol symbol;
  VoidCallback callback;
  bool isWinner;
  double cellSize;
  late Widget svg1;
  late Widget svg2;

  CellWidget(this.symbol, this.callback, this.isWinner, this.cellSize,
      {super.key}) {
    svg1 = Padding(
      padding: const EdgeInsets.all(6.0),
      child: SvgPicture.asset(
        assetName1,
        semanticsLabel: 'Cross',
        fit: BoxFit.contain,
      ),
    );
    svg2 = Padding(
      padding: const EdgeInsets.all(6.0),
      child: SvgPicture.asset(
        assetName2,
        semanticsLabel: 'Zero',
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget iconData;
    if (symbol == TicTacSymbol.cross) {
      iconData = svg1;
    } else if (symbol == TicTacSymbol.oval) {
      iconData = svg2;
    } else {
      iconData = SizedBox(width: cellSize, height: cellSize);
    }

    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: cellSize - 6,
          height: cellSize - 6,
          color: isWinner ? Colors.amberAccent : Colors.transparent,
          child: iconData,
        ),
      ),
    );
  }
}

const String assetName1 = 'assets/dog_ic.svg';
const String assetName2 = 'assets/rain.svg';
