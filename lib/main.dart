import 'package:bmi_calculator_app/contoller/bmi_provider.dart';
import 'package:bmi_calculator_app/contoller/language_provider.dart';
import 'package:bmi_calculator_app/contoller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bmi_calculator_app/screens/userinfo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ChangeNotifierProvider(create: (context) => LanguageProvider(),),
        ChangeNotifierProvider(create: (context) => BMIProvider(),),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) =>
          MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Provider.of<LanguageProvider>(context).locale,
            supportedLocales: const [
              Locale('en'),
              Locale('bn'),
            ],
            theme: _buildLightThemeData(),
            darkTheme: _buildDarkThemeData(),
            themeMode: themeProvider.themeMode,
            home: const UserInfoPage(),
        ),
      ),
    );
  }

  ThemeData _buildDarkThemeData() {
    return ThemeData.dark().copyWith(
          useMaterial3: true,
          primaryColor: const Color(0xff21325E),
          appBarTheme: const AppBarTheme(color: Color(0xff21325E)),
          scaffoldBackgroundColor: const Color(0xff3E497A),
          brightness: Brightness.dark,
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xff21325E)),
        );
  }

  ThemeData _buildLightThemeData() {
    return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.amber,
          appBarTheme: const AppBarTheme(color: Colors.amber),
          scaffoldBackgroundColor: Colors.white,
          buttonTheme: const ButtonThemeData(buttonColor: Color(0xff21325E)),
          iconTheme: const IconThemeData(color: Colors.white),
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
        );
  }
}
