import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:counter_button/counter_button.dart';
import 'package:ryzen5/screens/left-arm.dart';
import 'package:ryzen5/screens/right-arm.dart';
import 'package:ryzen5/screens/left-leg.dart';
import 'package:ryzen5/screens/right-leg.dart';

class leftArm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello World'),
      color: Colors.red,
    );
  }
}
