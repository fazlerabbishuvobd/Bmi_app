import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BMIProvider extends ChangeNotifier {
  // <----------------- Home Page -------------------->
  bool _isMale = true;
  bool get isMale => _isMale;
  void getGender() {
    _isMale = !_isMale;
    notifyListeners();
  }

  // <----------------- Height Page -------------------->
  double _feetSlider = 10;
  double get feetSlider => _feetSlider;
  void getFeetSliderValue(value) {
    _feetSlider = value;
    notifyListeners();
  }

  void increaseFeet() {
    _feetSlider += 0.1;
    notifyListeners();
  }

  void decreaseFeet() {
    _feetSlider -= 0.1;
    notifyListeners();
  }

  double _cmSlider = 150;
  double get cmSlider => _cmSlider;
  void getCmSliderValue(value) {
      _cmSlider = value;
      notifyListeners();
  }

  void increaseCM() {
    _cmSlider += 0.1;
    notifyListeners();
  }

  void decreaseCM() {
    _cmSlider -= 0.1;
    notifyListeners();
  }

  bool _isCM = true;
  bool get isCM => _isCM;
  void checkIsCM() {
    _isCM = !_isCM;
    notifyListeners();
  }

  // <----------------- Weight Page -------------------->
  double _currentSliderValue = 100.0;
  double get currentSliderValue => _currentSliderValue;

  void getSliderValue(double value) {
    _currentSliderValue = value;
    notifyListeners();
  }
}
