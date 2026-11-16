import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Authentic Netflix-inspired red wordmark logo and compact 'N' ribbon badge.
class NetflixLogo extends StatelessWidget {
  final double fontSize;
  final VoidCallback? onTap;
  final bool compact;

  const NetflixLogo({
    super.key,
    this.fontSize = 32,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget logoText = Text(
      compact ? 'N' : 'NETFLIX',
      style: TextStyle(
        color: AppTheme.netflixRed,
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        letterSpacing: compact ? 0 : 2.8,
        height: 1.0,
        shadows: const <Shadow>[
          Shadow(
            color: Color(0x99000000),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
    );

    if (onTap == null) {
      return logoText;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: logoText,
      ),
    );
  }
}

