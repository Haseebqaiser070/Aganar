// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import 'dart:ui';

import 'package:roulette/roulette.dart';
import 'dart:math';

class Ruleta extends StatefulWidget {
  const Ruleta({
    Key? key,
    this.width,
    this.height,
    required this.numSorteo,
  }) : super(key: key);

  final double? width;
  final double? height;
  final int numSorteo;

  @override
  _RuletaState createState() => _RuletaState();
}

class _RuletaState extends State<Ruleta> with SingleTickerProviderStateMixin {
  final colors = [
    Color(0xffE8EAF2),
    Color(0xff39B6B9),
    Color(0xffFFCC01),
    Color(0xff83378B),
    Color(0xffFE6D00),
    Color(0xff7DB343),
    Color(0xff415498),
  ];

  get text => null;

  Color getColor(int index) {
    return colors[index % colors.length];
  }

  late final RouletteController controller;

  @override
  void initState() {
    super.initState();
    final values = <int>[
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25
    ];
    final group = RouletteGroup.uniform(
      values.length,
      colorBuilder: (index) => getColor(index),
      textBuilder: (index) => (index + 1).toString(),
      /*textStyleBuilder: (index) {
        // Set the text style here!
      },*/
    );
    controller = RouletteController(group: group, vsync: this);
  }

  /*void initState() {
    super.initState();
    final units = List.generate(
        25, (index) => RouletteUnit.noText(color: getColor(index)));
    controller = RouletteController(group: RouletteGroup(units), vsync: this);
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Roulette(
            controller: controller,
            style: RouletteStyle(
              dividerThickness: 1,
              dividerColor: Colors.black,
              textLayoutBias: 0.9,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
              centerStickerColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            /*final random = Random();
            final randomIndex = random.nextInt(25);
            controller.rollTo(randomIndex);*/
            controller.rollTo(this.widget.numSorteo);
            Timer(Duration(seconds: 6), () {
              FFAppState().update(() {
                FFAppState().spinRoulette = true;
              });
            });
          },
          child: Text(''),
          style: TextButton.styleFrom(
            primary: Color.fromARGB(0, 200, 160, 120),
            padding: EdgeInsets.zero,
            minimumSize: Size(230, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
            side: BorderSide.none,
          ),
        ),
      ],
    );
  }
}
