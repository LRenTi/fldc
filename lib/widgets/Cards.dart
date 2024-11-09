import 'dart:math';
import 'package:fldc/helpers/theme/app_theme.dart';
import 'package:fldc/helpers/utils/my_shadow.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_card.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:url_launcher/url_launcher.dart';

class CardOpenExternal extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String url;

  CardOpenExternal({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      borderRadiusAll: 8,
      paddingAll: 15,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 12),
                  softWrap: true,
                ),
                SizedBox(height: 10),
                MyButton(
                  onPressed: () => launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  ),
                  elevation: 0,
                  borderRadiusAll: 8,
                  padding: MySpacing.xy(20, 16),
                  backgroundColor: AppTheme.primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Minimiert die Breite der Row
                    children: [
                      MyText.labelMedium(
                        "Open",
                        fontWeight: 600,
                        color: Colors.white,
                      ),
                      MySpacing.width(5),
                      Icon(
                        LucideIcons.arrow_up_right,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          MyContainer(
            paddingAll: 0,
            height: 54,
            width: 54,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadiusAll: 8,
            color: color.withAlpha(32),
            child: Icon(icon, color: color),
          ),
        ],
      ),
    );
  }
}