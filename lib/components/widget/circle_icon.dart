import 'package:flutter/material.dart';

Widget circleAvatar(
    {required Widget child,
    double? radius,
    Color? backgroundColor,
    bool? shadow}) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.transparent,
        boxShadow: [
          shadow == true
              ? BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                )
              : BoxShadow(),
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 30.0), child: child));
}
