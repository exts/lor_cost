import 'package:flutter/material.dart';

class CoinWidget extends StatelessWidget {
  final int coins;
  CoinWidget(this.coins);
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 20,
          height: 26,
          child: Image.asset("assets/coin_icon.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(coins.toString()),
        ),
      ],
    );
//    return Stack(
//      overflow: Overflow.visible,
//      children: <Widget>[
//        Positioned(
//          child: Container(
////            width: 100,
////            height: 30,
//            decoration: BoxDecoration(
//                color: Color(0xFFcad4d8),
//                shape: BoxShape.rectangle,
//                borderRadius: BorderRadius.circular(3),
//                border: Border.all(
//                  color: Color(0xFF66717e),
//                  style: BorderStyle.solid,
//                )),
//            child: Center(child: Text(coins.toString())),
//          ),
//        ),
//        Positioned(
//          top: -3,
//          child: Container(
//            width: 30,
//            height: 36,
//            child: Image.asset("assets/coin_icon.png"),
//          ),
//        ),
////        Text("Testing")
//      ],
//    );
  }
}
