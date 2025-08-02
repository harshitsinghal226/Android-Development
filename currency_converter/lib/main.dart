import 'package:currency_converter/currency_converter_cupertino_page.dart';
import 'package:currency_converter/currency_converter_material_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  //to tell flutter to come into an action and start running app
  runApp(const MyApp());
}

// Types of Widgets
// 1. StatelessWidget: Immutable, cannot change state after creation
// 2. StatefulWidget: Mutable, can change state during runtime
// upper two are used for creating UI components

// 3. InheritedWidget: Used for sharing data across the widget tree

// state is the data that can change during the lifetime of a widget

// 1. Material Design (created by Google, Android style)
// 2. Cupertino Design (iOS style )

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This method builds the UI of the widget

    return const MaterialApp(
      home: MaterialHomePage(),
    );

    /**this return is to print text in App */
    // return Text(
    //   'Hello, Flutter!',
    //   textDirection: TextDirection.ltr,
    //   style: TextStyle(
    //     fontSize: 24.0,
    //     color: Colors.blue,
    //     fontWeight: FontWeight.bold,
    //   ),
    // );
  }
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CurrencyConverterCupertinoPage(),
    );
  }
}
