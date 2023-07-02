import 'dart:io';
import 'dart:typed_data';
import 'package:bmi_calculator_app/screens/userinfo.dart';
import 'package:bmi_calculator_app/utils/constant.dart';
import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_buttonSheet.dart';
import 'package:bmi_calculator_app/widgets/custom_container.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultPage extends StatefulWidget {
  double hw;
  double ww;
  ResultPage({super.key, required this.hw, required this.ww});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  String _userName = '';
  String _userAge = '';

  @override
  void initState() {
    _loadSharedPreferences().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> _loadSharedPreferences() async {
    final sharedPreference = await SharedPreferences.getInstance();
    _userName = sharedPreference.getString('userName') ?? '';
    _userAge = sharedPreference.getString('userAge') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double bmi = widget.ww / (widget.hw * widget.hw);

    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).bmiResult,
            style: customBodyText(Colors.white, 24, FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppBarTheme.of(context).backgroundColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // <-----------------BMI Result Circular Indicator----------------------->
                new CircularPercentIndicator(
                  radius: 70.0,
                  lineWidth: 15.0,
                  percent: 0.59,
                  animation: true,
                  animationDuration: 1200,
                  center: new Text(
                    "${bmi.toStringAsFixed(2)} \nKG/m2",
                    style:
                        customHeadingText(Colors.blueGrey, 20, FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  progressColor: getColor(bmi),
                ),
                const SizedBox(
                  height: 10,
                ),

                // <----------------- NAME & MASSAGE ----------------------->
                RichText(
                    text: TextSpan(
                        text: '${AppLocalizations.of(context).resultMassage1} ',
                        style:
                            customBodyText(Colors.black, 14, FontWeight.normal),
                        children: [
                      TextSpan(
                          text: _userName,
                          style: customBodyText(
                              Colors.black, 16, FontWeight.bold)),
                      TextSpan(
                          text:
                              ' , ${AppLocalizations.of(context).resultMassage2} ',
                          style: customBodyText(
                              Colors.black, 16, FontWeight.normal)),
                      TextSpan(
                          text: getMassage(bmi, context),
                          style: customBodyText(
                              getColor(bmi), 16, FontWeight.bold)),
                    ])),
                const SizedBox(
                  height: 10,
                ),

                // <----------------- AGE HEIGHT WEIGHT----------------------->
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customContainer(
                        text: AppLocalizations.of(context).resultAge,
                        value:
                            '${_userAge} ${AppLocalizations.of(context).resultAgeYear}',
                        color: Colors.amber),
                    customContainer(
                        text: AppLocalizations.of(context).resultHeight,
                        value:
                            '${widget.hw.toStringAsFixed(2)} ${AppLocalizations.of(context).resultHeightM}',
                        color: Colors.amber),
                    customContainer(
                        text: AppLocalizations.of(context).resultWeight,
                        value:
                            '${widget.ww.toStringAsFixed(2)} ${AppLocalizations.of(context).resultWeightKg}',
                        color: Colors.amber),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),

                // <----------------- TABLE ----------------------->
                Table(
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                      width: 2),
                  children: List.generate(
                      tableData.length,
                      (index) => TableRow(
                              decoration:
                                  BoxDecoration(color: tableColor[index]),
                              children: [
                                TableCell(
                                    child: Text(
                                  '${tableData[index]['cell1']}',
                                  style: customBodyText(CupertinoColors.black,
                                      14, FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  '${tableData[index]['cell2']}',
                                  style: customBodyText(CupertinoColors.black,
                                      14, FontWeight.normal),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  '${tableData[index]['cell3']} -',
                                  style: customBodyText(CupertinoColors.black,
                                      14, FontWeight.bold),
                                  textAlign: TextAlign.right,
                                )),
                              ])),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),

                // <----------------- NET WEIGHT ----------------------->
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context).netWeight,
                      style: customHeadingText(
                          CupertinoColors.black, 16, FontWeight.normal),
                    ),
                    Text(
                      '${netWeight(bmi, widget.hw)} ${AppLocalizations.of(context).resultWeightKg}',
                      style:
                          customHeadingText(getColor(bmi), 16, FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Spacer(),

                // <----------------- BUTTON (HOME & SHARE) ----------------------->
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => UserInfoPage(),
                              ),
                              (route) => false);
                        },
                        buttonTxt: AppLocalizations.of(context).homeButton,
                        icons: Icons.home_filled,
                        color: Colors.deepPurple,
                        height: 56),
                    InkWell(
                      onTap: () {
                        showBottomSheets(context, () async {
                          String result =
                              'Hello, $_userName\n|| AGE: $_userAge years || HEIGHT: ${widget.hw.toStringAsFixed(2)} m || WEIGHT: ${widget.ww.toStringAsFixed(2)} KG ||\nYour BMI result is ${bmi.toStringAsFixed(2)} KG/m^2';
                          Share.share(result);
                        }, () async {
                          final tempDir = await getTemporaryDirectory();
                          final tempPath = tempDir.path;
                          final tempFile = File('$tempPath/screenshot.png');
                          final Uint8List? imageBytes =
                              await _screenshotController.capture();
                          await tempFile.writeAsBytes(imageBytes!);
                          await Share.shareXFiles([XFile(tempFile.path)]);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: 56,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurpleAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.share),
                            Text(AppLocalizations.of(context).shareButton),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
