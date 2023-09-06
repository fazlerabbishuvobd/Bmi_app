import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomColor {
  static const Color lightModeAppBar = Color(0xFF00AEEF);
}

List<Map<String, dynamic>> tableData = [
  {
    'cell1': 'S/L',
    'cell2': 'Details',
    'cell3': 'Range',
  },
  {
    'cell1': 1,
    'cell2': 'Very Underweight',
    'cell3': '>16',
  },
  {
    'cell1': 2,
    'cell2': 'Severely underweight',
    'cell3': '16.0-16.9',
  },
  {
    'cell1': 3,
    'cell2': 'Underweight',
    'cell3': '17.0-18.4',
    'color': Colors.green,
  },
  {
    'cell1': 4,
    'cell2': 'Normal',
    'cell3': '18.5-24.9',
    'color': Colors.deepPurpleAccent,
  },
  {
    'cell1': 5,
    'cell2': 'Overweight',
    'cell3': '25.0-29.9',
  },
  {
    'cell1': 6,
    'cell2': 'Obese Class I',
    'cell3': '30.0-34.9',
  },
  {
    'cell1': 7,
    'cell2': 'Obese Class II',
    'cell3': '35.0-39.9',
  },
  {
    'cell1': 8,
    'cell2': 'Obese class III',
    'cell3': '>39.9',
  },
];

List<Color> tableColor = [
  Colors.amber,
  Colors.green,
  Colors.deepPurpleAccent,
  Colors.blue,
  Colors.deepPurple,
  Colors.red,
  Colors.pink,
  Colors.blueGrey,
  Colors.brown
];

Color getColor(double value) {
  if (0 <= value && value < 16) {
    return Colors.pinkAccent;
  } else if (16 <= value && value < 17) {
    return Colors.green;
  } else if (17 <= value && value < 18.5) {
    return Colors.deepPurpleAccent;
  } else if (18.5 <= value && value < 25) {
    return Colors.grey;
  } else if (25 <= value && value < 30) {
    return Colors.blue;
  } else if (30 <= value && value < 35) {
    return Colors.amber;
  } else if (35 <= value && value < 40) {
    return Colors.purple;
  } else {
    return Colors.red;
  }
}

String netWeight(double value,double h) {
  if (0 <= value && value < 16) {
    return '${(0*(h*h)).toStringAsFixed(2)} - ${(15.9*(h*h)).toStringAsFixed(2)}';
  } else if (16 <= value && value < 17) {
    return '${(16*(h*h)).toStringAsFixed(2)} - ${(16.9*(h*h)).toStringAsFixed(2)}';
  } else if (17 <= value && value < 18.5) {
    return '${(17*(h*h)).toStringAsFixed(2)} - ${(18.4*(h*h)).toStringAsFixed(2)}';
  } else if (18.5 <= value && value < 25) {
    return '${(18.5*(h*h)).toStringAsFixed(2)} - ${(24.9*(h*h)).toStringAsFixed(2)}';
  } else if (25 <= value && value < 30) {
    return '${(25*(h*h)).toStringAsFixed(2)} - ${(29.9*(h*h)).toStringAsFixed(2)}';
  } else if (30 <= value && value < 35) {
    return '${(30*(h*h)).toStringAsFixed(2)} - ${(34.9*(h*h)).toStringAsFixed(2)}';
  } else if (35 <= value && value < 40) {
    return '${(35*(h*h)).toStringAsFixed(2)} - ${(39.9*(h*h)).toStringAsFixed(2)}';
  } else {
    return '${(40*(h*h)).toStringAsFixed(2)} <';
  }
}


String getMassage(double value,BuildContext context) {
  if (0 <= value && value < 16) {
    return AppLocalizations.of(context)!.n1Details;
  } else if (16 <= value && value < 17) {
    return AppLocalizations.of(context)!.n2Details;
  } else if (17 <= value && value < 18.5) {
    return AppLocalizations.of(context)!.n3Details;
  } else if (18.5 <= value && value < 25) {
    return AppLocalizations.of(context)!.n4Details;
  } else if (25 <= value && value < 30) {
    return AppLocalizations.of(context)!.n5Details;
  } else if (30 <= value && value < 35) {
    return AppLocalizations.of(context)!.n6Details;
  } else if (35 <= value && value < 40) {
    return AppLocalizations.of(context)!.n7Details;
  } else {
    return AppLocalizations.of(context)!.n8Details;
  }
}