import 'package:fldc/controller/auth_2/forgot_password_controller.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/view/layouts/auth_layout_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with UIMixin {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return AuthLayout2(
      child: GetBuilder(
        init: controller,
        tag: 'auth_2forgot_password_controller',
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
                  MyText.titleLarge("Forgot Password",
                      fontWeight: 600, color: contentTheme.onPrimary),
                  MySpacing.width(12),
                  Expanded(child: Divider())
                ]),
                MySpacing.height(32),
                Center(
                  child: MyText.bodyMedium(
                      "Enter your email to get password reset instructions.",
                      fontWeight: 800,
                      textAlign: TextAlign.center,
                      letterSpacing: .5,
                      muted: true,
                      color: contentTheme.onPrimary),
                ),
                MySpacing.height(20),
                email(),
                MySpacing.height(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [resetPasswordButton()],
                ),
                Spacer(),
                Center(
                  child: InkWell(
                      onTap: () => controller.backToLogin(),
                      child: MyText.bodyMedium("Back to Login",
                          color: contentTheme.onPrimary, fontWeight: 600)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget resetPasswordButton() {
    return MyButton(
        onPressed: () => controller.onResetPassword(),
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
            MyText.bodyMedium("Reset Password",
                fontWeight: 600, color: contentTheme.onPrimary),
            MySpacing.width(8),
            Icon(LucideIcons.chevron_right,
                size: 20, color: contentTheme.onPrimary),
          ],
        ));
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
}
