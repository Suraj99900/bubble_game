import 'dart:async';

import 'package:bubble_game/ball.dart';
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

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;

  //for midshot fire
  bool midShot = false;

  //missilevariable
  double missileX = playerX;
  double missileY = 1;
  double missileHeight = 10;

  //ball variables
  double ballX = 0.05;
  double ballY = 0;
  var ballDirection = direction.LEFT;
  //start game function
  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 100; //show jump of the ball

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // quadratic equation that modals a bounce (upside down prabola)
      height = -5 * time * time + velocity * time;
      // if the ball reach the ground ,reset the jump
      if (height < 0) {
        time = 0;
      }
      setState(() {
        ballY = heightToCoordinate(height);

        if (ballX - 0.005 < -1) {
          //  if the ball hits the left , then change direction to right
          ballDirection = direction.RIGHT;
        } else if (ballX + 0.005 > 1) {
          //  if the ball hits the left , then change direction to right
          ballDirection = direction.LEFT;
        }
        // move the ball in the correct direction
        if (ballDirection == direction.LEFT) {
          setState(() {
            ballX -= 0.005;
          });
        } else if (ballDirection == direction.RIGHT) {
          setState(() {
            ballX += 0.005;
          });
        }

        // check if ball hit's the ball
        if (playerDies()) {
          timer.cancel();
          _showDialog();
        }
        //keep going the ball
        time += 0.1;
      });
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Center(
              child: Text(
                "Game Over !",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        });
  }

  //moving player function
  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
        //do nothing
      } else {
        playerX -= 0.1;
      }

      // only make the x coordinate the same when it isn't in the middle of a shot
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
        //do nothing
      } else {
        playerX += 0.1;
      }

      // only make the x coordinate the same when it isn't in the middle of a shot
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void moveFire() {
    if (midShot == false) {
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        //shots fired
        midShot = true;

        // missile grow til it hit's the top of the screen
        setState(() {
          missileHeight += 10;
        });

        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          //stop missile when it reach top of the screen

          resetMissile();
          timer.cancel();
        }
        //check if missile has hit ball
        if (ballY > heightToCoordinate(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }
  }

  // convert hight to coordinate
  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
    midShot = false;
  }

  bool playerDies() {
    //if the ball touch the player {game over}
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
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
                    MyBall(ballX: ballX, ballY: ballY), //MyBall
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
                  icon: Icons.play_arrow,
                  function: startGame,
                ),
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
