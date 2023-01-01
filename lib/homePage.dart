import 'dart:async';

import 'package:bubble_game/button.dart';
import 'package:bubble_game/missile.dart';
import 'package:bubble_game/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double playerX = 0;

  //missilevariable
  double missileX = playerX;
  double missileY = 1;
  double missileHeight = 10;

  void moveLeft() {
    setState(() {
      if (playerX - 0.2 < -1) {
        //do nothing
      } else {
        playerX -= 0.2;
      }
      missileX = playerX;
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.2 > 1) {
        //do nothing
      } else {
        playerX += 0.2;
      }
      missileX = playerX;
    });
  }

  void moveFire() {
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
        //stop missile
        resetMissile();
        timer.cancel();
      } else {
        setState(() {
          missileHeight += 10;
        });
      }
    });
  }

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          moveFire();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    Missile(
                      missileX: missileX,
                      missileY: missileY,
                      missileHeight: missileHeight,
                    ),
                    MyPlayer(
                      playerX: playerX,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  icon: Icons.arrow_back,
                  function: moveLeft,
                ),
                MyButton(
                  icon: Icons.arrow_upward,
                  function: moveFire,
                ),
                MyButton(
                  icon: Icons.arrow_forward,
                  function: moveRight,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
