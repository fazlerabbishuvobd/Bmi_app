import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton({
  IconData? icons,
  required VoidCallback onPressed,
  required String buttonTxt,
  double? height,
  double? width,
  Color? color
})
{
  return Card(
    elevation: 5,
    color: color,
    child: MaterialButton(
      onPressed: onPressed,
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonTxt,
              style: customHeadingText(CupertinoColors.black, 18, FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Icon(icons),
          ],
        ),
      ),
    ),
  );
}
