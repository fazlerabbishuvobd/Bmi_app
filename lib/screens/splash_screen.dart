import 'package:bmi_calculator_app/screens/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserInfoPage(),))
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.2,
            ),
            Text('BMI MEASURE APP',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.amber),
              ),
            ),

            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.05,
            ),

            Column(
              children: [
                const SpinKitCircle(
                  color: Colors.amber,
                  size: 50.0,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.05,
                ),

                Text('Design & Developed By',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                  ),
                ),

                Text('FAZLE RABBI',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
