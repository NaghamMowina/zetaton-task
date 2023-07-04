import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/core/helpers/app_toast.dart';
import 'package:zetaton_task/core/helpers/assets_helper.dart';
import 'package:zetaton_task/core/themes/themes.dart';
import 'package:zetaton_task/core/widgets/custom_button.dart';
import 'package:zetaton_task/features/authentication/model/user_model.dart';
import 'package:zetaton_task/features/authentication/presentation/widgets/widgets.dart';
import 'package:zetaton_task/features/authentication/provider/auth_provider.dart';
import 'package:zetaton_task/features/home/presentation/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                    height: 90.h,
                  ),
                ),
                30.verticalSpace,

                const LabelWidget(label: 'First Name'),
                10.verticalSpace,

                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: firstnameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
                25.verticalSpace,
                const LabelWidget(label: 'Last Name'),
                10.verticalSpace,

                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: lastnameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
                25.verticalSpace,
                const LabelWidget(label: 'Mobile number'),
                10.verticalSpace,

                CustomTextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
                25.verticalSpace,
                const LabelWidget(label: 'Email'),
                10.verticalSpace,

                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
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
                ),
                // const Center(
                //     child: CustomButton(
                //   isDisabled: false,
                //   title: 'Login',
                // )),
                // Text(
                //   l10n.receiveOtpSentence,
                //   textAlign: TextAlign.left,
                //   //  style: AppStyles.text16PxRegular,
                // ),
                30.verticalSpace,
                Consumer<AuthProvider>(builder: (_, authState, __) {
                  return CustomButton(
                    isDisabled: false,
                    loading: authState.showLoading,
                    width: double.infinity,
                    onPressed: () async {
                      // if (controller.text.isNotEmpty) {

                      // }
                      if (_formKey.currentState!.validate()) {
                        UserModel userModel = UserModel(
                            email: emailController.text,
                            password: passwordController.text,
                            firstname: firstnameController.text,
                            lastname: lastnameController.text,
                            phone: int.parse(phoneController.text));
                        await authState.registerUser(model: userModel);
                      }
                      if (authState.userModel != null) {
                        AppToast.successToast('Successfully registered');
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomePage()));
                      }
                    },
                    title: 'Register',
                  );
                }),
                30.verticalSpace
              ],
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
              'Have an account already? ',
              style: AppStyles.blackTextStyle20_400,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Login',
                style: AppStyles.primaryTextStyle18_700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
