import 'package:flutter/material.dart';

Widget nonMandatoryHeader(String text,TextStyle style) {
  return Row(
    children: [
      Text(text, style: style),
    ],
  );
}

Widget mandatoryHeader(String text,TextStyle style) {
  return Row(
    children: [
      Text(text, style: style),
      const SizedBox(width:5),
      const Text('*', style: TextStyle(color: Colors.red,fontSize: 15)),
    ],
  );
}
