import 'package:fldc/controller/auth/forgot_password_controller.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ForgotPasswordController controller;

  @override
  void initState() {
    controller = ForgotPasswordController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        tag: 'fldc_forgot_password_controller',
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
                MyText.titleLarge("Forgot Password", fontWeight: 600),
                MySpacing.height(12),
                MyText.bodyMedium(
                    "Please, enter the email associated with your account and we'll send an email with link, where you can change your password.",
                    fontWeight: 600),
                MySpacing.height(24),
                buildField(),
                MySpacing.height(24),
                MyButton.block(
                    elevation: 0,
                    padding: MySpacing.y(20),
                    borderRadiusAll: 8,
                    backgroundColor: contentTheme.primary,
                    onPressed: () => controller.onLogin(),
                    child: MyText.bodyMedium(
                      "Forgot Password",
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                    )),
                MyButton.text(
                    onPressed: () => controller.gotoLogIn(),
                    child: MyText.bodyMedium("Back to login", fontWeight: 600))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildField() {
    return Form(
      key: controller.basicValidator.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Enter Email", fontWeight: 700),
          MySpacing.height(8),
          fldcTextField(
            validator: controller.basicValidator.getValidation('email'),
            controller: controller.basicValidator.getController('email'),
            hintText: "Email",
          ),
        ],
      ),
    );
  }
}
