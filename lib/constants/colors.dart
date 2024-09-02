import 'dart:math';
import 'dart:ui';

class AppColors {
  static final List<Color> _taskItemColors = [
    const Color(0xFFFFB3BA),
    const Color(0xFFFFDEB8),
    const Color(0xFFFFFFB8),
    const Color(0xFFB8FFC7),
    const Color(0xFFB8E0FF),
    const Color(0xFFB3BAFF),
    const Color(0xFFDEB8FF),
    const Color(0xFFB8FFF0),
    const Color(0xFFFFB8E0),
    const Color(0xFFC7FFB8),
  ];

  static Color getColor(int index) {
    return _taskItemColors[index % _taskItemColors.length];
  }

  const AppColors();
}
