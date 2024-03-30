// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DeviceSize {
  mobile,
  tablet,
  desktop,
}

abstract class FlutterFlowTheme {
  static DeviceSize deviceSize = DeviceSize.mobile;

  static FlutterFlowTheme of(BuildContext context) {
    deviceSize = getDeviceSize(context);
    return LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color primaryBtnText;
  late Color lineColor;
  late Color grayIcon;
  late Color gray200;
  late Color gray600;
  late Color black600;
  late Color tertiary400;
  late Color textColor;
  late Color backgroundComponents;
  late Color maximumBlueGreen;
  late Color plumpPurple;
  late Color platinum;
  late Color ashGray;
  late Color darkSeaGreen;
  late Color neon;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => {
        DeviceSize.mobile: MobileTypography(this),
        DeviceSize.tablet: TabletTypography(this),
        DeviceSize.desktop: DesktopTypography(this),
      }[deviceSize]!;
}

DeviceSize getDeviceSize(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 479) {
    return DeviceSize.mobile;
  } else if (width < 991) {
    return DeviceSize.tablet;
  } else {
    return DeviceSize.desktop;
  }
}

// class LightModeTheme extends FlutterFlowTheme {
//   @Deprecated('Use primary instead')
//   Color get primaryColor => primary;
//   @Deprecated('Use secondary instead')
//   Color get secondaryColor => secondary;
//   @Deprecated('Use tertiary instead')
//   Color get tertiaryColor => tertiary;
//
//   late Color primary = const Color(0xFFC09848);
//   late Color secondary = const Color(0xFFF2EED4);
//   late Color tertiary = const Color(0xFF01082F);
//   late Color alternate = const Color(0xFFA3967A);
//   late Color primaryText = const Color(0xFF222628);
//   late Color secondaryText = const Color(0xFF57636C);
//   late Color primaryBackground = const Color(0xFFF1F4F8);
//   late Color secondaryBackground = const Color(0xFFFFFFFF);
//   late Color accent1 = const Color(0xFF616161);
//   late Color accent2 = const Color(0xFF757575);
//   late Color accent3 = const Color(0xFFE0E0E0);
//   late Color accent4 = const Color(0xFFEEEEEE);
//   late Color success = const Color(0xFF04A24C);
//   late Color warning = const Color(0xFFFCDC0C);
//   late Color error = const Color(0xFFE21C3D);
//   late Color info = const Color(0xFF1C4494);
//
//   late Color primaryBtnText = Color(0xFFFFFFFF);
//   late Color lineColor = Color(0xFFE0E3E7);
//   late Color grayIcon = Color(0xFF95A1AC);
//   late Color gray200 = Color(0xFFDBE2E7);
//   late Color gray600 = Color(0xFF262D34);
//   late Color black600 = Color(0xFF090F13);
//   late Color tertiary400 = Color(0xFF39D2C0);
//   late Color textColor = Color(0xFF1E2429);
//   late Color backgroundComponents = Color(0xFF1D2428);
//   late Color maximumBlueGreen = Color(0xFF59C3C3);
//   late Color plumpPurple = Color(0xFF52489C);
//   late Color platinum = Color(0xFFEBEBEB);
//   late Color ashGray = Color(0xFFCAD2C5);
//   late Color darkSeaGreen = Color(0xFF84A98C);
// }




// class LightModeTheme extends FlutterFlowTheme {
//   @Deprecated('Use primary instead')
//   Color get primaryColor => primary;
//   @Deprecated('Use secondary instead')
//   Color get secondaryColor => secondary;
//   @Deprecated('Use tertiary instead')
//   Color get tertiaryColor => tertiary;
//
//   late Color primary = const Color.fromARGB(50, 158, 119, 241);
//   late Color secondary = const Color(0xFFF2EED4);
//   late Color tertiary = const Color(0xFF01082F);
//   late Color alternate = const Color(0xFFA3967A);
//   late Color primaryText = const Color(0xFFE0E0E0);
//   late Color secondaryText = const Color(0xFF57636C);
//   late Color primaryBackground = const Color.fromARGB(255, 43, 43, 61);
//   late Color secondaryBackground = const Color.fromARGB(250, 180, 155, 232);
//   late Color accent1 = const Color(0xFF616161);
//   late Color accent2 = const Color(0xFF757575);
//   late Color accent3 = const Color(0xFFE0E0E0);
//   late Color accent4 = const Color(0xFFEEEEEE);
//   late Color success = const Color(0xFF04A24C);
//   late Color warning = const Color(0xFFFCDC0C);
//   late Color error = const Color(0xFFE21C3D);
//   late Color info = const Color(0xFF1C4494);
//
//   late Color primaryBtnText = Color(0xFFFFFFFF);
//   late Color lineColor = Color(0xFFE0E3E7);
//   late Color grayIcon = Color(0xFF95A1AC);
//   late Color gray200 = Color(0xFFDBE2E7);
//   late Color gray600 = Color(0xFF262D34);
//   late Color black600 = Color(0xFF090F13);
//   late Color tertiary400 = Color(0xFF39D2C0);
//   late Color textColor = Color(0xFF1E2429);
//   late Color backgroundComponents = Color(0xFF1D2428);
//   late Color maximumBlueGreen = Color(0xFF59C3C3);
//   late Color plumpPurple = Color(0xFF52489C);
//   late Color platinum = Color(0xFFEBEBEB);
//   late Color ashGray = Color(0xFFCAD2C5);
//   late Color darkSeaGreen = Color(0xFF84A98C);
// }


class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color.fromARGB(50, 158, 119, 241);
  late Color secondary = const Color(0xFFF2EED4);
  late Color tertiary = const Color(0xFF01082F);
  late Color alternate = const Color(0xFFA3967A);
  late Color primaryText = const Color(0xFFE0E0E0);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color.fromARGB(255, 0, 0, 0);
  // late Color secondaryBackground = const Color.fromARGB(255, 118, 62, 245);
  late Color secondaryBackground = const Color.fromARGB(250, 144, 38, 219);
  late Color accent1 = const Color(0xFF616161);
  late Color accent2 = const Color(0xFF757575);
  late Color accent3 = const Color(0xFFE0E0E0);
  late Color accent4 = const Color(0xFFEEEEEE);
  late Color success = const Color(0xFF04A24C);
  late Color warning = const Color(0xFFFCDC0C);
  late Color error = const Color(0xFFE21C3D);
  late Color info = const Color(0xFF1C4494);

  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFFE0E3E7);
  late Color grayIcon = Color(0xFF95A1AC);
  late Color gray200 = Color(0xFFDBE2E7);
  late Color gray600 = Color(0xFF262D34);
  late Color black600 = Color(0xFF090F13);
  late Color tertiary400 = Color(0xFF39D2C0);
  late Color textColor = Color(0xFF1E2429);
  late Color backgroundComponents = Color(0xFF1D2428);
  late Color maximumBlueGreen = Color(0xFF59C3C3);
  late Color plumpPurple = Color(0xFF52489C);
  late Color platinum = Color(0xFFEBEBEB);
  late Color ashGray = Color(0xFFCAD2C5);
  late Color darkSeaGreen = Color(0xFF84A98C);
  late Color neon = Color.fromARGB(255, 249, 43, 249);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class MobileTypography extends Typography {
  MobileTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Noto Sans Hebrew';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      );
  String get displayMediumFamily => 'Noto Sans Hebrew';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Noto Sans Hebrew';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get headlineLargeFamily => 'Noto Sans Hebrew';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Noto Sans Hebrew';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineSmallFamily => 'Noto Sans Hebrew';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Noto Sans Hebrew';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 26.0,
      );
  String get titleMediumFamily => 'Noto Sans Hebrew';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleSmallFamily => 'Noto Sans Hebrew';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.accent3,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Noto Sans Hebrew';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelMediumFamily => 'Noto Sans Hebrew';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get labelSmallFamily => 'Noto Sans Hebrew';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  String get bodyLargeFamily => 'Montserrat';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Montserrat',
        color: theme.primaryText,
      );
  String get bodyMediumFamily => 'Montserrat';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Montserrat',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodySmallFamily => 'Montserrat';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Montserrat',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
}

class TabletTypography extends Typography {
  TabletTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Noto Sans Hebrew';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      );
  String get displayMediumFamily => 'Noto Sans Hebrew';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Noto Sans Hebrew';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get headlineLargeFamily => 'Noto Sans Hebrew';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Noto Sans Hebrew';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineSmallFamily => 'Noto Sans Hebrew';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Noto Sans Hebrew';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Noto Sans Hebrew';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleSmallFamily => 'Noto Sans Hebrew';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Noto Sans Hebrew';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelMediumFamily => 'Noto Sans Hebrew';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get labelSmallFamily => 'Noto Sans Hebrew';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  String get bodyLargeFamily => '';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Roboto',
      );
  String get bodyMediumFamily => 'Noto Sans Hebrew';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodySmallFamily => 'Noto Sans Hebrew';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
}

class DesktopTypography extends Typography {
  DesktopTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Noto Sans Hebrew';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      );
  String get displayMediumFamily => 'Noto Sans Hebrew';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Noto Sans Hebrew';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get headlineLargeFamily => 'Noto Sans Hebrew';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Noto Sans Hebrew';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineSmallFamily => 'Noto Sans Hebrew';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Noto Sans Hebrew';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Noto Sans Hebrew';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleSmallFamily => 'Noto Sans Hebrew';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Noto Sans Hebrew';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelMediumFamily => 'Noto Sans Hebrew';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get labelSmallFamily => 'Noto Sans Hebrew';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  String get bodyLargeFamily => '';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Roboto',
      );
  String get bodyMediumFamily => 'Noto Sans Hebrew';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodySmallFamily => 'Noto Sans Hebrew';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Noto Sans Hebrew',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
