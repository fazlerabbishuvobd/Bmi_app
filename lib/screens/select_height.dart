import 'package:bmi_calculator_app/contoller/bmi_provider.dart';
import 'package:bmi_calculator_app/screens/select_weight.dart';
import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectHeight extends StatefulWidget {
  final String gender;

  const SelectHeight({super.key, required this.gender});

  @override
  State<SelectHeight> createState() => _SelectHeightState();
}

class _SelectHeightState extends State<SelectHeight> {
  double _currentSliderValue = 150.0;
  double sliderValue = 150.0;

  @override
  Widget build(BuildContext context) {
    final heightProviders = Provider.of<BMIProvider>(context);
    final isCM = Provider.of<BMIProvider>(context).isCM;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    double cmTometer = heightProviders.cmSlider * 0.01;
    double feetTometer = heightProviders.feetSlider * 0.3048;

    /// Define Slider Value CM max = 260 & Feet max = 10
    isCM ? _currentSliderValue = heightProviders.cmSlider : _currentSliderValue = heightProviders.feetSlider;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(AppLocalizations.of(context)!.heightChoose, style: customBodyText(Colors.white, 20, FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppBarTheme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            /// Top Part
            Container(
              alignment: Alignment.center,
              width: width * 0.8,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  // <----------------- BUTTON INCREASE DECREASE ----------------------->
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDecreaseButton(isCM, heightProviders, context),

                      Text(isCM ? '${_currentSliderValue.toStringAsFixed(1)} ${AppLocalizations.of(context)!.cm}' : '${_currentSliderValue.toStringAsFixed(1)} ${AppLocalizations.of(context)!.feet}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                      _buildIncreaseButton(isCM, heightProviders, context),
                    ],
                  ),

                  Text(isCM ? '${cmTometer.toStringAsFixed(2)} ${AppLocalizations.of(context)!.m}' : '${feetTometer.toStringAsFixed(2)} ${AppLocalizations.of(context)!.m}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),

            // <-----------------BMI Result Circular Indicator----------------------->
            SizedBox(
              height: height * 0.65,
              width: width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Button
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCMButton(),
                        _buildFeetButton(),
                      ],
                    ),
                  ),

                  ///Slider
                  RotatedBox(
                    quarterTurns: 3,
                    child: isCM ? _buildCMSlider(width, heightProviders) : _buildFeetSlider(width, heightProviders, context),
                  ),

                  _buildImage(height, isCM)
                ],
              ),
            ),
            const Spacer(),

            _buildNextButton(context, isCM, cmTometer, feetTometer, width)
          ],
        ),
      ),
    );
  }

  Widget _buildDecreaseButton(bool isCM, BMIProvider heightProviders, BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.red,
      child: IconButton(
          style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
          onPressed: () {
            if ( isCM ? heightProviders.cmSlider > 0 : heightProviders.feetSlider > 0 ) {
              isCM ? heightProviders.decreaseCM() : heightProviders.decreaseFeet();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(_buildSnackBarCM(isCM, context));
            }
          },
          icon: const Icon(Icons.remove)),
    );
  }

  SnackBar _buildSnackBarCM(bool isCM, BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepPurple),
        child: Text(isCM ? AppLocalizations.of(context)!.snackbarHl : AppLocalizations.of(context)!.snackbarFl,
          style: customBodyText(Colors.yellow, 16, FontWeight.bold),
        ),
      )
  );
  }

  Widget _buildIncreaseButton(bool isCM, BMIProvider heightProviders, BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.green,
      child: IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
          onPressed: () {
            if (isCM ? 0 < heightProviders.cmSlider && heightProviders.cmSlider < 260 : 0 < heightProviders.feetSlider && heightProviders.feetSlider < 10) {
              isCM ? heightProviders.increaseCM() : heightProviders.increaseFeet();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(_buildCMSnackBar(isCM, context));
            }
          },
          icon: const Icon(Icons.add)),
    );
  }

  SnackBar _buildCMSnackBar(bool isCM, BuildContext context) {
    return SnackBar(
        backgroundColor: Colors.white,
        content: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepPurple),
          child: Text(
            isCM ? AppLocalizations.of(context)!.snackbarHh : AppLocalizations.of(context)!.snackbarFh,
            style: customBodyText(Colors.yellow,
                16, FontWeight.bold),
          ),
        )
    );
  }

  Widget _buildNextButton(BuildContext context, bool isCM, double cmTometer, double feetTometer, double width) {
    return customButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
            SelectWeight(
              gender: widget.gender,
              h: isCM ? cmTometer : feetTometer,
            )
          )
        );
      },
      buttonTxt: AppLocalizations.of(context)!.nextButton,
      icons: Icons.skip_next,
      height: 56,
      width: width,
      color: Colors.amber);
  }

  Consumer<BMIProvider> _buildFeetButton() {
    return Consumer<BMIProvider>(
      builder: (context, heightProvider, child) =>
        SizedBox(
          child: customButton(
            onPressed: () {
            heightProvider.checkIsCM();
          },
          buttonTxt: AppLocalizations.of(context)!.feet,
          icons: Icons.height,
          height: 56,
          width: 100,
        )
      ),
    );
  }

  Consumer<BMIProvider> _buildCMButton() {
    return Consumer<BMIProvider>(
      builder: (context, heightProvider, child) => SizedBox(
          child: customButton(
        onPressed: () {
          heightProvider.checkIsCM();
        },
        buttonTxt: AppLocalizations.of(context)!.cm,
        icons: Icons.height,
        height: 56,
        width: 100,
      )
      ),
    );
  }

  Widget _buildImage(double height, bool isCM) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            widget.gender == 'Male' ? 'assets/images/man.png' : 'assets/images/woman.png',
            height: isCM ? _currentSliderValue * 1.65 : _currentSliderValue * 40,
          ),
        ],
      ),
    );
  }

  Widget _buildFeetSlider(double width, BMIProvider heightProviders, BuildContext context) {
    return SizedBox(
      width: width,
      child: SfSlider(
        min: 0,
        value: heightProviders.feetSlider,
        max: 10,
        onChanged: (value) {
          if (value < 11) {
            heightProviders.getFeetSliderValue(value);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.white,
                    content: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple),
                      child: Text(
                        AppLocalizations.of(context)!.snackbarFh,
                        style: customBodyText(Colors.yellow, 16, FontWeight.bold),
                      ),
                    )
              )
            );
          }
        },
        interval: 2,
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
      )
    );
  }

  Widget _buildCMSlider(double width, BMIProvider heightProviders) {
    return SizedBox(
        width: width,
        child: SfSlider(
          min: 10,
          value: heightProviders.cmSlider,
          max: 260,
          onChanged: (value) {
            heightProviders.getCmSliderValue(value);
          },
          interval: 50,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
        )
    );
  }
}
