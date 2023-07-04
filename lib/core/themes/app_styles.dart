import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zetaton_task/core/themes/themes.dart';

class AppStyles {
  const AppStyles._();
  static TextStyle get primaryTextStyle18_700 => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
      );
        static TextStyle get primaryTextStyle24_400 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColor,
      );
  static TextStyle get blackTextStyle18_700 => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.blackColor,
      );
  static TextStyle get blackTextStyle20_400 => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blackColor,
      );
  static TextStyle get primaryTextStyle14 => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColor,
      );
}
