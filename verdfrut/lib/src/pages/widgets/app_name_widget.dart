import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenfrut/src/config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? purpleTitleColor;
  final double textSize;

  const AppNameWidget({
    Key? key,
    this.purpleTitleColor,
    this.textSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.playball(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'verd',
            style: TextStyle(
              color: CustomColors.customSwatchColor,
            ),
          ),
          TextSpan(
            text: 'frut',
            style: TextStyle(
              color: purpleTitleColor ?? CustomColors.customContrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
