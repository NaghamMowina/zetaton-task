import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/core/helpers/app_toast.dart';
import 'package:zetaton_task/core/helpers/assets_helper.dart';
import 'package:zetaton_task/core/themes/themes.dart';
import 'package:zetaton_task/core/widgets/custom_button.dart';
import 'package:zetaton_task/features/authentication/presentation/pages/pages.dart';
import 'package:zetaton_task/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:zetaton_task/features/authentication/provider/auth_provider.dart';
import 'package:zetaton_task/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 25.verticalSpace,
                  Center(
                    child: Image.asset(
                      AssetsHelper.logo,
                      height: 150.h,
                    ),
                  ),
                  30.verticalSpace,
                  Text(
                    'Email',
                    style: AppStyles.blackTextStyle18_700,
                    textAlign: TextAlign.center,
                  ),
                  // 32.verticalSpace,
                  10.verticalSpace,

                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    filled: true,
                  ),
                  25.verticalSpace,
                  Text(
                    'Password',
                    style: AppStyles.blackTextStyle18_700,
                    textAlign: TextAlign.center,
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    filled: true,
                    controller: passwordController,
                    obscureText: true,
                  ),
                  25.verticalSpace,
                  // const Center(
                  //     child: CustomButton(
                  //   isDisabled: false,
                  //   title: 'Login',
                  // )),
                  Consumer<AuthProvider>(builder: (_, authState, __) {
                    return CustomButton(
                      isDisabled: false,
                      loading: authState.showLoading,
                      width: double.infinity,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authState.loginUser(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                        if (authState.userModel != null) {
                          AppToast.successToast('Successfully logged in');
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const HomePage()));
                        }
                      },
                      title: 'Login',
                    );
                  }),

                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(5.w),
        color: AppColors.whiteColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account? ',
              style: AppStyles.blackTextStyle20_400,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const RegisterPage()));
              },
              child: Text(
                'Register',
                style: AppStyles.primaryTextStyle18_700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
