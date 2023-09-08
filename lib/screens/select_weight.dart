import 'package:bmi_calculator_app/contoller/bmi_provider.dart';
import 'package:bmi_calculator_app/screens/result_page.dart';
import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectWeight extends StatefulWidget {
  final String gender;
  final double h;
  const SelectWeight({super.key, required this.gender, required this.h});

  @override
  State<SelectWeight> createState() => _SelectWeightState();
}

class _SelectWeightState extends State<SelectWeight> {

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back, color: Colors.white,
        )
        ),
        title: Text(AppLocalizations.of(context)!.weightChoose,
          style: customBodyText(Colors.white, 20, FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppBarTheme.of(context).backgroundColor,
      ),

      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [


            //Image
            SizedBox(
              height: height * 0.45,
              width: 200,
              child: Image.asset(widget.gender == 'Male' ? 'assets/images/man.png' : 'assets/images/woman.png',
              ),
            ),


            //SleekSlider
            Consumer<BMIProvider>(
              builder: (context, sleekProvider, child) => SleekCircularSlider(
                max: 250,
                min: 0,
                initialValue: 50,
                onChange: (value) {
                  sleekProvider.getSliderValue(value);
                },
                appearance: CircularSliderAppearance(
                  size: 250,
                  customColors: CustomSliderColors(
                    progressBarColor: Colors.amber,
                    trackColor: Colors.amber.shade200,
                  ),
                  infoProperties: InfoProperties(modifier: (percentage) => '${sleekProvider.currentSliderValue.toStringAsFixed(1)}KG',
                  ),
                ),
              ),
            ),
            const Spacer(),

            //Calculate BMI Button
            Consumer<BMIProvider>(
              builder: (context, navProvider, child) => customButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ResultPage(ww: navProvider.currentSliderValue, hw: widget.h,)), (route) => false,);
                },
                buttonTxt: AppLocalizations.of(context)!.calculateBMI,
                icons: Icons.calculate_outlined,
                height: 56,
                width: width,
                color: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }

}
