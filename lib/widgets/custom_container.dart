import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key,this.color,required this.text,required this.value});

  final Color? color;
  final String text,value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,style: customHeadingText(Colors.black, 16, FontWeight.bold),),
              const SizedBox(height: 4,),
              Text(value,style: customHeadingText(Colors.black, 14, FontWeight.normal))
            ],
          )
      ),
    );
  }
}
