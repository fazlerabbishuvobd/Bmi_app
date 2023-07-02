import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

Widget customContainer ({Color? color, required String text,required String value}){
  return  Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$text',style: customHeadingText(CupertinoColors.black, 16, FontWeight.bold),),
            SizedBox(height: 4,),
            Text('$value',style: customHeadingText(CupertinoColors.black, 14, FontWeight.normal))
          ],
        )),
  );
}