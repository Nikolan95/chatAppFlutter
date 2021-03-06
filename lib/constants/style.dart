import 'package:flutter/material.dart';

class Style {
  /// Atev Colors
  static final Color primaryColor = Color(0xFFE9A943);
  static final Color secondaryColor = Color(0xFFE9A943);

  ///Dröschler Colors
  //static final Color primaryColor = Color(0xFF4E72AA);
  //static final Color secondaryColor = Color(0xFF4E72AA);
  static final Color darkColor = Color(0xFF151515);
  static final List<Color> gradientColors = [primaryColor, secondaryColor];

  /// Text Style
  static final TextStyle appNameTextStyle =
      TextStyle(fontSize: 32, fontWeight: FontWeight.w500);

  /// Decorations
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: '$label',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }
}
