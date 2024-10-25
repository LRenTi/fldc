import 'package:fldc/controller/auth_2/reset_password_controller.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/helpers/widgets/my_text_style.dart';
import 'package:fldc/view/layouts/auth_layout_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with UIMixin {
  ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return AuthLayout2(
        child: GetBuilder(
      init: controller,
      tag: 'auth_2_reset_password_controller',
      builder: (controller) {
        return Form(
          key: controller.basicValidator.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(child: Divider()),
                MySpacing.width(12),
                MyText.titleLarge("Reset Password",
                    fontWeight: 600, color: contentTheme.onPrimary),
                MySpacing.width(12),
                Expanded(child: Divider())
              ]),
              MySpacing.height(32),
              Center(
                child: MyText.bodyMedium(
                    "Make sure to save your password in a password manager!",
                    fontWeight: 800,
                    textAlign: TextAlign.center,
                    letterSpacing: .5,
                    muted: true,
                    color: contentTheme.onPrimary),
              ),
              MySpacing.height(32),
              password(),
              MySpacing.height(24),
              confirmPassword(),
              MySpacing.height(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [resetPasswordButton()],
              ),
            ],
          ),
        );
      },
    ));
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

  Widget password() {
    return TextFormField(
      controller: controller.passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
      onChanged: (value) => controller.password = value,
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

  Widget confirmPassword() {
    return TextFormField(
      controller: controller.confirmPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a confirm password';
        }
        if (value != controller.passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onChanged: (value) => controller.confirmPassword = value,
      style: MyTextStyle.bodyMedium(
          fontWeight: 700,
          muted: true,
          letterSpacing: .5,
          color: contentTheme.onPrimary),
      keyboardType: TextInputType.visiblePassword,
      obscureText: controller.isConfirmPassword,
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
              onTap: controller.onShowConfirmPassword,
              child: Icon(controller.isConfirmPassword
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
          focusedErrorBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: contentTheme.danger)),
          enabledBorder: outlineInputBorder),
    );
  }
}
