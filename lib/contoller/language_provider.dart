import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{

  bool _value = false;
  bool get value => _value;
  void switchVal(bool switchValue){
    _value = switchValue;
    notifyListeners();
  }

  Locale _locale =  const Locale('en');
  Locale get locale => _locale;
  void changeLanguage(bool value){
    if(value==false)
      {
        _locale = const Locale('en');
      }
    else{
      _locale = const Locale('bn');
    }
    notifyListeners();
  }

}