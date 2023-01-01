// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Missile extends StatelessWidget {
  final missileX;
  final missileY;
  final missileHeight;
  const Missile({super.key, this.missileHeight, this.missileX, this.missileY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        width: 5,
        height: missileHeight,
        color: const Color.fromARGB(255, 255, 17, 0),
      ),
    );
  }
}
