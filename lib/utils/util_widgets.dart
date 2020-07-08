import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenwriting/utils/util_colors.dart';

class UtilWidgets {
  Widget arrowButton() {
    return Container(
      height: 56.0,
      width: 90.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: UtilColors.richBrown,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 24.0,
      ),
    );
  }
}
