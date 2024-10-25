import 'package:fldc/controller/auth_2/login_controller.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/view/layouts/auth_layout_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with UIMixin {
  LoginController controller = Get.put(LoginController());
  @override
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return AuthLayout2(
      child: GetBuilder(
        init: controller,
        tag: 'auth_2_login_controller',
        builder: (controller) {
          return Form(
            key: controller.basicValidator.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Row(children: [
                  Expanded(child: Divider()),
                  MySpacing.width(12),
                  MyText.titleLarge("SignIn",
                      fontWeight: 600, color: contentTheme.onPrimary),
                  MySpacing.width(12),
                  Expanded(child: Divider())
                ]),
                MySpacing.height(32),
                Center(
                  child: MyText.bodyMedium(
                      "Welcome to fldc! Please Fill your e-mail and password to sign in into your account",
                      fontWeight: 800,
                      textAlign: TextAlign.center,
                      letterSpacing: .5,
                      muted: true,
                      color: contentTheme.onPrimary),
                ),
                MySpacing.height(32),
                email(),
                MySpacing.height(24),
                password(),
                MySpacing.height(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.goToForgotPassword(),
                        child: MyText.bodyMedium("Forgot Password?",
                            fontWeight: 700,
                            muted: true,
                            color: contentTheme.onPrimary),
                      ),
                    ),
                    loginButton(),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.bodyMedium("don't have an account?",
                        fontWeight: 600, color: contentTheme.onPrimary),
                    MySpacing.width(4),
                    InkWell(
                      onTap: () => controller.goToRegister(),
                      child: MyText.bodyMedium("Register",
                          fontWeight: 700,
                          decoration: TextDecoration.underline,
                          color: contentTheme.onPrimary),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget email() {
    return TextFormField(
      controller: controller.basicValidator.getController('email'),
      validator: controller.basicValidator.getValidation('email'),
      style: MyTextStyle.bodyMedium(
          fontWeight: 700,
          muted: true,
          letterSpacing: .5,
          color: contentTheme.onPrimary),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Email Address",
          isDense: true,
          hintStyle:
              MyTextStyle.bodyMedium(fontWeight: 600, color: Colors.grey),
          contentPadding: MySpacing.all(20),
          prefixIcon: Icon(LucideIcons.mail),
          prefixIconColor: WidgetStateColor.resolveWith(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.error)) {
                return contentTheme.danger;
              }
              return contentTheme.onPrimary;
            },
          ),
          border: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: contentTheme.danger)),
          focusedBorder: outlineInputBorder,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: contentTheme.danger)),
          enabledBorder: outlineInputBorder),
    );
  }

  Widget password() {
    return TextFormField(
      controller: controller.basicValidator.getController('password'),
      validator: controller.basicValidator.getValidation('password'),
      style: MyTextStyle.bodyMedium(
          fontWeight: 700,
          muted: true,
          letterSpacing: .5,
          color: contentTheme.onPrimary),
      keyboardType: TextInputType.visiblePassword,
      obscureText: controller.isShowPassword,
      decoration: InputDecoration(
          hintText: "Password",
          isDense: true,
          hintStyle:
              MyTextStyle.bodyMedium(fontWeight: 600, color: Colors.grey),
          contentPadding: MySpacing.all(20),
          prefixIcon: Icon(LucideIcons.lock),
          prefixIconColor: WidgetStateColor.resolveWith(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.error)) {
                return contentTheme.danger;
              }
              return contentTheme.onPrimary;
            },
          ),
          suffixIcon: InkWell(
              onTap: controller.onShowPasswordToggle,
              child: Icon(controller.isShowPassword
                  ? LucideIcons.eye
                  : LucideIcons.eye_off)),
          suffixIconColor: WidgetStateColor.resolveWith(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.error)) {
                return contentTheme.danger;
              }
              return contentTheme.onPrimary;
            },
          ),
          border: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: contentTheme.danger)),
          focusedBorder: outlineInputBorder,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: contentTheme.danger)),
          enabledBorder: outlineInputBorder),
    );
  }

  Widget loginButton() {
    return MyButton(
        onPressed: () => controller.onLogin(),
        soft: true,
        tapTargetSize: MaterialTapTargetSize.padded,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          minimumSize: WidgetStatePropertyAll(Size(150, 44)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.bodyMedium("Login",
                fontWeight: 600, color: contentTheme.onPrimary),
            MySpacing.width(8),
            Icon(LucideIcons.chevron_right,
                size: 20, color: contentTheme.onPrimary),
          ],
        ));
  }
}
