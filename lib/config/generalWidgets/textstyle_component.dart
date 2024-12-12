
 // ignore_for_file: must_be_immutable
 
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
class TextComponents extends StatelessWidget {
  final title;
  double size;
  final weight;
  final color;
  final decoration;
  final textAlign;
  final TextOverflow? overflow;
  TextComponents({
    Key? key,
    required this.title,
    required this.size,
    this.weight,
    this.color,
    this.decoration,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize:   size.sp,
        color: color,
        fontWeight: weight,
        decoration: decoration,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
