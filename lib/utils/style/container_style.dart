import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ContainerAppStyle {
  BoxDecoration boderItemMenu() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: hexToColor('#ababab'),
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    );
  }
}
