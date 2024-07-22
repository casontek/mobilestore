
import 'package:flutter/cupertino.dart';

Widget customTextWidget({
  required String label,
  required double size,
  required FontWeight weight,
  required Color textColor
}) {
  return Text(
    label,
    style: TextStyle(
        fontSize: size,
        fontFamily: 'Roboto',
        fontWeight: weight,
        color: textColor
    ),
    maxLines: 1,
    textAlign: TextAlign.start,
    overflow: TextOverflow.ellipsis,
  );
}