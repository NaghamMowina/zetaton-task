import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zetaton_task/core/themes/themes.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.title,
      this.validator,
      this.maxLines,
      this.readOnly,
      this.textCapitalization,
      this.controller,
      required this.keyboardType,
      this.icon,
      this.focusNode,
      this.isPasswordField = false,
      this.onTap,
      this.hint,
      this.length,
      this.inputFormatters,
      this.prefix,
      this.filled,
      this.obscureText});
  final TextEditingController? controller;
  final Widget? prefix;
  final String? hint;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? title;
  final TextInputType keyboardType;
  final IconData? icon;
  final Function? onTap;
  final bool? readOnly;
  final bool? isPasswordField;
  final String? Function(String?)? validator;
  final int? length;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? filled;
  final bool? obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText??false,
      style: const TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
      ),
      maxLines: widget.maxLines ?? 1,
      maxLength: widget.length,
      onTap: widget.onTap != null ? widget.onTap as Function() : null,
      readOnly: widget.readOnly ?? false,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'This field can\'t be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefix,
        fillColor: AppColors.primaryColor.withOpacity(0.05),
        filled: widget.filled ?? true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
