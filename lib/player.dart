// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  const MyPlayer({super.key, this.playerX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: Container(
            color: Colors.purple,
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
