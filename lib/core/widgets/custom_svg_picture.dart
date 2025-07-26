import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.svgAssetPath,
    this.width,
    this.height,
    this.withcolorfilter = true,
  });
  const CustomSvgPicture.withcolorfilter({
    super.key,
    required this.svgAssetPath,
    this.width,
    this.height,
  }) : withcolorfilter = false;
  final String svgAssetPath;
  final int? width;
  final int? height;
  final bool withcolorfilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgAssetPath,
      colorFilter:
          withcolorfilter
              ? ColorFilter.mode(
                ThemeController.isDark()
                    ? Color(0xffC6C6C6)
                    : Color(0xff3A4640),
                BlendMode.srcIn,
              )
              : null,
    );
  }
}
