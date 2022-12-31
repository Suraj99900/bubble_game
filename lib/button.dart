// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'dart:html';

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final icon;
  final function;
  const MyButton({super.key, this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.grey[100],
          child: Center(child: Icon((icon))),
        ),
      ),
    );
  }
}
