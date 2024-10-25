import 'package:fldc/controller/auth/reset_password_controller.dart';
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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ResetPasswordController controller;

  @override
  void initState() {
    controller = ResetPasswordController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        tag: 'fldc_reset_password_controller',
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
                MyText.titleLarge("Reset Password", fontWeight: 600),
                MySpacing.height(12),
                MyText.bodyMedium(
                    "Don't use a variation of an old password or any personal information",
                    fontWeight: 600),
                MySpacing.height(24),
                buildField(),
                MySpacing.height(24),
                MyButton.block(
                    elevation: 0,
                    borderRadiusAll: 8,
                    padding: MySpacing.y(20),
                    backgroundColor: contentTheme.primary,
                    onPressed: () => controller.onLogin(),
                    child: MyText.bodyMedium(
                      "Reset Password",
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildField() {
    return Form(
      key: controller.basicV.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Password", fontWeight: 700),
          MySpacing.height(8),
          fldcTextField(
            onChanged: (value) {
              setState(() {
                controller.password = value;
              });
            },
            controller: controller.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            hintText: "Password",
            obscureText: controller.showPassword,
            suffixIcon: InkWell(
              onTap: () => controller.onChangeShowPassword(),
              child: Icon(
                  controller.showPassword
                      ? LucideIcons.eye_off
                      : LucideIcons.eye,
                  size: 20),
            ),
          ),
          MySpacing.height(20),
          MyText.bodyMedium("Confirm Password", fontWeight: 700),
          MySpacing.height(8),
          fldcTextField(
            onChanged: (value) {
              setState(() {
                controller.confirmPassword1 = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a confirm password';
              }
              if (value != controller.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            controller: controller.confirmPasswordController,
            hintText: "Confirm Password",
            obscureText: controller.confirmPassword,
            suffixIcon: InkWell(
              onTap: () => controller.onResetPassword(),
              child: Icon(
                  controller.confirmPassword
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
