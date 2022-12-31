// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.grey[100],
        child: Center(child: Icon(Icons.arrow_back)),
      ),
    );
  }
}
