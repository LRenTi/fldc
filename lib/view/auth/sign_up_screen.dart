import 'package:fldc/controller/auth/sign_up_controller.dart';
import 'package:fldc/helpers/utils/mixins/ui_mixin.dart';
import 'package:fldc/helpers/widgets/my_button.dart';
import 'package:fldc/helpers/widgets/my_container.dart';
import 'package:fldc/helpers/widgets/my_spacing.dart';
import 'package:fldc/helpers/widgets/my_text.dart';
import 'package:fldc/images.dart';
import 'package:fldc/view/layouts/auth_layout.dart';
import 'package:fldc/widgets/fldc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SignUpController controller;

  @override
  void initState() {
    controller = SignUpController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        tag: 'fldc_sign_up_controller',
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
                MyText.titleLarge("Create an Account", fontWeight: 600),
                MySpacing.height(12),
                MyText.bodyMedium(
                    "Hello, We're glad you're here. Create your account below",
                    fontWeight: 600),
                MySpacing.height(24),
                buildFields(),
                MySpacing.height(24),
                MyButton.block(
                    elevation: 0,
                    borderRadiusAll: 8,
                    padding: MySpacing.y(20),
                    backgroundColor: contentTheme.primary,
                    onPressed: controller.onLogin,
                    child: MyText.bodyMedium(
                      "Register Account",
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
                    onTap: () => controller.gotoLogin(),
                    child: MyText.bodyMedium(
                      "Already have an account?",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium("Enter First Name", fontWeight: 700),
                    MySpacing.height(8),
                    fldcTextField(
                      controller:
                          controller.basicValidator.getController('first_name'),
                      validator:
                          controller.basicValidator.getValidation('first_name'),
                      hintText: "First Name",
                    ),
                  ],
                ),
              ),
              MySpacing.width(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium("Enter Last Email", fontWeight: 700),
                    MySpacing.height(8),
                    fldcTextField(
                      controller:
                          controller.basicValidator.getController('last_name'),
                      validator:
                          controller.basicValidator.getValidation('last_name'),
                      hintText: "Last Name",
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(20),
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
