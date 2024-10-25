import 'package:fldc/controller/auth/login_controller.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/auth_layout.dart';
import 'package:fldc/widgets/flow_kit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late LoginController controller;

  @override
  void initState() {
    controller = LoginController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        tag: 'fldc_login_screen',
        init: controller,
        builder: (controller) {
          return Padding(
            padding: MySpacing.x(MediaQuery.of(context).size.width * .03),
            child: Column(
              children: [
                MyContainer(
                    height: 40,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.logo,
                        fit: BoxFit.cover, width: 150)),
                MySpacing.height(44),
                MyText.titleLarge("Welcome Back !", fontWeight: 600),
                MySpacing.height(12),
                MyText.bodyMedium(
                    "Enter your email and choose password to setup your account.",
                    fontWeight: 600),
                MySpacing.height(24),
                buildFields(),
                Row(
                  children: [
                    Theme(
                      data:
                          ThemeData(unselectedWidgetColor: Colors.transparent),
                      child: Checkbox(
                        activeColor: contentTheme.primary,
                        value: controller.isCheckToggle,
                        onChanged: (value) => controller.onSelectToggle(),
                        visualDensity: getCompactDensity,
                      ),
                    ),
                    MySpacing.width(12),
                    MyText.bodyMedium("Remember Me", fontWeight: 600),
                    Spacer(),
                    MyButton.text(
                        onPressed: () => controller.gotoForgotPasswordScreen(),
                        child: MyText.bodyMedium("Forgot Password?",
                            fontWeight: 600))
                  ],
                ),
                MySpacing.height(24),
                MyButton.block(
                    elevation: 0,
                    borderRadiusAll: 8,
                    padding: MySpacing.y(20),
                    backgroundColor: contentTheme.primary,
                    onPressed: () => controller.onLogin(),
                    child: MyText.bodyMedium(
                      "Login",
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                    )),
                MySpacing.height(24),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    MyContainer.roundBordered(
                        paddingAll: 0,
                        height: 30,
                        width: 30,
                        child: Center(
                            child: MyText.bodySmall("OR", fontWeight: 700))),
                    Expanded(child: Divider()),
                  ],
                ),
                MySpacing.height(24),
                MyContainer.bordered(
                  borderRadiusAll: 8,
                  paddingAll: 0,
                  height: 44,
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyContainer(
                        height: 20,
                        width: 20,
                        paddingAll: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(Images.google, fit: BoxFit.cover),
                      ),
                      MySpacing.width(12),
                      MyText.bodyMedium("Sign up with Google", fontWeight: 600),
                    ],
                  ),
                ),
                MySpacing.height(24),
                InkWell(
                    onTap: () => controller.goToRegisterScreen(),
                    child: MyText.bodyMedium(
                      "I haven't account",
                      fontWeight: 600,
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildFields() {
    return Form(
      key: controller.basicValidator.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Enter Email", fontWeight: 700),
          MySpacing.height(8),
          fldcTextField(
            controller: controller.basicValidator.getController('email'),
            validator: controller.basicValidator.getValidation('email'),
            hintText: "Email",
          ),
          MySpacing.height(20),
          MyText.bodyMedium("Enter Password", fontWeight: 700),
          MySpacing.height(8),
          fldcTextField(
            controller: controller.basicValidator.getController('password'),
            validator: controller.basicValidator.getValidation('password'),
            hintText: "Password",
            obscureText: controller.obscureText,
            suffixIcon: InkWell(
              onTap: () => controller.showPasswordToggle(),
              child: Icon(
                  controller.obscureText
                      ? LucideIcons.eye_off
                      : LucideIcons.eye,
                  size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
