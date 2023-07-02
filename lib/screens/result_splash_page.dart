import 'package:bmi_calculator_app/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ResultSplash extends StatefulWidget {
  const ResultSplash({super.key});

  @override
  State<ResultSplash> createState() => _ResultSplashState();
}

class _ResultSplashState extends State<ResultSplash> {



  @override
  void initState() {
   // Future.delayed(Duration(seconds: 1)).then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>ResultPage()), (route) => false));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
