import 'package:flutter/material.dart';

Color getTileColor(int value) {
  switch (value) {
    case 2:
      return Colors.yellow;
    case 4:
      return Colors.orange;
    case 8:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
