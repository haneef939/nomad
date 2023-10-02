import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData getThemeData() {
    return _buildLightTheme();
    return _themeData();
  }

  static TextTheme _textTheme() {
    return TextTheme();
  }

  static ThemeData _buildLightTheme() {
    Color primaryColor = Color(0xffF9683A);

    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: Color(0xffF9683A),
      // buttonColor: primaryColor,
      splashFactory: InkRipple.splashFactory,
      // accentColor: Colors.black,
      backgroundColor: Colors.white,
      errorColor: const Color(0xffF6C634),
      // cursorColor: primaryColor,
      typography: Typography(),
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      // accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      button: GoogleFonts.openSans(
          textStyle: TextStyle(
              color: base.button?.color,
              fontSize: 14,
              fontWeight: FontWeight.w600)),
      caption: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.caption?.color, fontSize: 12)),
      overline: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.overline?.color, fontSize: 10)),
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8,
      margin: EdgeInsets.all(0),
    );
  }

  static ThemeData _themeData() {
    Color primaryColor = Color(0xffF9683A);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: Colors.black,
      secondary: Colors.black,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      //  primaryColor: HexColor("#005CEE"),
      // buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      //  accentColor: const Color(0xffFFFFFF),
      // canvasColor: Colors.white,
      // backgroundColor: const Color(0xff0000000),
      // scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      // accentTextTheme: _textTheme(),
      platform: TargetPlatform.android,
      // cursorColor: primaryColor,
      // buttonBarTheme: _buttonThemeData(colorScheme)
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
