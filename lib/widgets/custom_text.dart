
import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customBodyText(Color? color, double? size,FontWeight?fontWeight){
  return GoogleFonts.ysabeau(
    color: color,
    fontSize: size,
    fontWeight: fontWeight,
  );
}

TextStyle customHeadingText(Color? color, double? size , FontWeight? weight){
  return GoogleFonts.lato(
    color: color,
    fontSize: size,
    fontWeight: weight,
  );
}