// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//   static const Color primaryBlue = Color(0xFF159FE3);
//   static const Color darkNavy = Color(0xFF102A56);
//   static const Color lightBlue = Color(0xFFEAF7FD);

//   static ThemeData theme = ThemeData(
//     useMaterial3: true,

//     scaffoldBackgroundColor: Colors.white,

//     colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),

//     // Global application font
//     textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),

//     appBarTheme: const AppBarTheme(
//       backgroundColor: darkNavy,
//       foregroundColor: Colors.white,
//     ),

//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryBlue,
//         foregroundColor: Colors.white,
//       ),
//     ),

//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(foregroundColor: primaryBlue),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ============================================================
  // ONE ENTERPRISE CLOUD DESIGN SYSTEM
  // ============================================================

  // Core
  static const Color ink = Color(0xFF0F1330);
  static const Color ink2 = Color(0xFF181D42);
  static const Color ink3 = Color(0xFF232A5C);

  // Accent colors
  static const Color amberAI = Color(0xFFE8A33D);
  static const Color tealData = Color(0xFF4FD1C5);

  // Surface & Text
  static const Color paper = Color(0xFFFFFFFF);
  static const Color paperDim = Color(0xFFF4F5F7);
  static const Color border = Color(0xFFE5E7EB);
  static const Color text = Color(0xFF14171F);
  static const Color textMuted = Color(0xFF6B7280);

  // Semantic colors
  static const Color success = Color(0xFF2E9E5B);
  static const Color danger = Color(0xFFD14343);
  static const Color info = Color(0xFF2F6FE0);
  static const Color warning = Color(0xFFC8862A);

  // ============================================================
  // SPACING
  // ============================================================

  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space48 = 48;

  // ============================================================
  // RADIUS
  // ============================================================

  static const double radiusSmall = 6;
  static const double radiusDefault = 10;
  static const double radiusLarge = 12;
  static const double radiusPill = 999;

  // ============================================================
  // THEME
  // ============================================================

  static ThemeData get theme {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      // ----------------------------------------------------------
      // Global
      // ----------------------------------------------------------

      scaffoldBackgroundColor: paper,

      colorScheme: const ColorScheme(
        brightness: Brightness.light,

        primary: ink,
        onPrimary: Colors.white,

        secondary: tealData,
        onSecondary: ink,

        tertiary: amberAI,
        onTertiary: ink,

        error: danger,
        onError: Colors.white,

        surface: paper,
        onSurface: text,

        surfaceContainerHighest: paperDim,
        outline: border,
      ),

      // ----------------------------------------------------------
      // Typography
      // ----------------------------------------------------------
      textTheme: GoogleFonts.onestTextTheme(baseTheme.textTheme).copyWith(
        // Page titles
        headlineLarge: GoogleFonts.onest(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        headlineMedium: GoogleFonts.onest(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        // Section titles
        titleLarge: GoogleFonts.onest(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        titleMedium: GoogleFonts.onest(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        // Labels / controls
        labelLarge: GoogleFonts.onest(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        labelMedium: GoogleFonts.onest(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        // Body
        bodyLarge: GoogleFonts.onest(
          fontSize: 14.5,
          fontWeight: FontWeight.w400,
          color: text,
        ),

        bodyMedium: GoogleFonts.onest(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: text,
        ),

        bodySmall: GoogleFonts.onest(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
      ),

      // ----------------------------------------------------------
      // AppBar
      // ----------------------------------------------------------
      appBarTheme: const AppBarTheme(
        backgroundColor: ink,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      // ----------------------------------------------------------
      // Cards
      // ----------------------------------------------------------
      cardTheme: CardThemeData(
        color: paper,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          side: const BorderSide(color: border),
        ),
      ),

      // ----------------------------------------------------------
      // Primary Buttons
      // ----------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ink,
          foregroundColor: Colors.white,

          elevation: 0,

          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault),
          ),

          textStyle: GoogleFonts.onest(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ----------------------------------------------------------
      // Outlined Buttons
      // ----------------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          side: const BorderSide(color: border),

          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusDefault),
          ),

          textStyle: GoogleFonts.onest(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ----------------------------------------------------------
      // Text Buttons
      // ----------------------------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ink,

          textStyle: GoogleFonts.onest(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ----------------------------------------------------------
      // Input Fields
      // ----------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: paper,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),

        labelStyle: GoogleFonts.onest(fontSize: 14, color: textMuted),

        hintStyle: GoogleFonts.onest(fontSize: 14, color: textMuted),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: border),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: ink3, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: danger),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: danger, width: 1.5),
        ),
      ),

      // ----------------------------------------------------------
      // Divider
      // ----------------------------------------------------------
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),

      // ----------------------------------------------------------
      // Chips
      // ----------------------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: paperDim,
        selectedColor: ink,
        secondarySelectedColor: tealData,

        labelStyle: GoogleFonts.onest(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusPill),
          side: const BorderSide(color: border),
        ),
      ),

      // ----------------------------------------------------------
      // Data Tables
      // ----------------------------------------------------------
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(paperDim),

        dataRowColor: WidgetStateProperty.all(paper),

        headingTextStyle: GoogleFonts.onest(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: text,
        ),

        dataTextStyle: GoogleFonts.onest(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: text,
        ),

        dividerThickness: 1,
      ),

      // ----------------------------------------------------------
      // Tooltip
      // ----------------------------------------------------------
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: ink2,
          borderRadius: BorderRadius.circular(radiusSmall),
        ),

        textStyle: GoogleFonts.onest(fontSize: 12, color: Colors.white),
      ),

      // ----------------------------------------------------------
      // Drawer
      // ----------------------------------------------------------
      drawerTheme: const DrawerThemeData(backgroundColor: ink),

      // ----------------------------------------------------------
      // Icon Theme
      // ----------------------------------------------------------
      iconTheme: const IconThemeData(color: textMuted, size: 20),
    );
  }

  // ============================================================
  // MONOSPACE TYPOGRAPHY
  // For IDs, codes, timestamps and literal values
  // ============================================================

  static TextStyle mono({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    Color color = text,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // ============================================================
  // COMMON STATUS COLORS
  // ============================================================

  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return success;

      case 'inactive':
      case 'suspended':
      case 'rejected':
        return danger;

      case 'pending':
      case 'pending renewal':
        return warning;

      case 'draft':
        return textMuted;

      default:
        return info;
    }
  }
}
