import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{

  bool _value = false;
  bool get value => _value;
  void switchVal(bool switchValue){
    _value = switchValue;
    notifyListeners();
  }

  Locale _locale =  Locale('en');
  Locale get locale => _locale;
  void changeLanguage(bool value){
    if(value==false)
      {
        _locale = Locale('en');
      }
    else{
      _locale = Locale('bn');
    }
    notifyListeners();
  }

}