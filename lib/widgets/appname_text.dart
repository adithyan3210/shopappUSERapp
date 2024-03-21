import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/widgets/title_text.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key,  this.fontSize=30});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(seconds: 5),
        baseColor: Colors.purple,
        highlightColor: Colors.red,
        child: TitleTextWidget(
          label: "My Shop App",
          fontSize: fontSize,
        ));
  }
}
