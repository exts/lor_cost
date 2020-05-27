import 'package:flutter/material.dart';

class ShardWidget extends StatelessWidget {
  final int shards;
  ShardWidget(this.shards);

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 20,
          height: 26,
          child: Image.asset("assets/shards_icon.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(shards.toString()),
        ),
      ],
    );
  }
}
