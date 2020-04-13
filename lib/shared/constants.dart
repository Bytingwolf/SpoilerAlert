import 'package:flutter/material.dart';

class Constants {
  static const String settings = 'Settings';
  static const String signOut = 'Logout';
  static const String addFood = 'Add';
  static const String editFood = 'Edit';
  static const String bestBefore = 'Best Before';
  static const String useBy = 'Use By';
  static const String frozen = 'Frozen';

  static const List<String> choices = <String>[
    addFood,
    editFood,
    settings,
    signOut
  ];

  static const List<String> foodType = <String>[
    bestBefore,
    useBy,
    frozen,
  ];
}

const textInputDecoration = InputDecoration(
    /*fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0)
  )*/
    );
