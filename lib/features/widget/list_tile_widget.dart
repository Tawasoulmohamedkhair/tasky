import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    this.onTap,
    required this.svgAssetPath,
    required this.title,
    this.iconData,
    this.switchWidget,
  });
  final Function()? onTap;
  final String svgAssetPath;
  final String title;
  final IconData? iconData;
  final Switch? switchWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      contentPadding: EdgeInsets.all(0),
      leading: CustomSvgPicture(svgAssetPath: svgAssetPath),

      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.displayMedium!.copyWith(fontSize: 16),
      ),
      trailing:
          iconData != null
              ? Icon(
                iconData,
                color:
                    ThemeController.isDark()
                        ? Color(0xffC6C6C6)
                        : Color(0xff3A4640),
              )
              : switchWidget,
    );
  }
}
