import 'package:flutter/material.dart';
import 'package:zetaton_task/core/themes/themes.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppStyles.blackTextStyle18_700,
      textAlign: TextAlign.center,
    );
  }
}
