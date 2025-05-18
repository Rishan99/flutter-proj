import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/utility/validator.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/auth/model/signup_model.dart';
import 'package:moviehub/services/auth/auth_service.dart';
import 'package:moviehub/services/core/preference_service.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/form_title_widget.dart';
import 'package:moviehub/widgets/visibility_widget.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppDefaults.kPageSidePadding,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                FormSeperatorBox(),
                FormTitleWidget(
                  title: "Full Name",
                  child: TextFormField(
                    controller: nameController,
                    validator: Validators.emptyFieldValidator,
                  ),
                ),
                FormSeperatorBox(),
                FormTitleWidget(
                  title: "Email Address",
                  child: TextFormField(
                    controller: emailController,
                    validator: Validators.emptyFieldValidator,
                  ),
                ),
                FormSeperatorBox(),
                FormTitleWidget(
                  title: "Password",
                  child: TextFormField(
                    obscureText: obscurePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                        suffixIcon: CustomInkWell(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: VisibilityWidget(
                        isVisibile: !obscurePassword,
                      ),
                    )),
                    validator: Validators.emptyFieldValidator,
                  ),
                ),
                FormSeperatorBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomInkWell(
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                  ),
                ),
                FormSeperatorBox(),
                TextButton(
                  onPressed: () {
                    asyncCallHelperWithLoadingBar(context, processCall: () async {
                      await locator<AuthService>().register(SignupModel(
                        email: emailController.text,
                        name: nameController.text,
                        password: passwordController.text,
                      ));
                    }, onSuccess: () {
                      displayToastSuccess("Registered successfully");
                      Navigator.pop(
                        context,
                      );
                    });
                  },
                  child: Text('Signup'),
                ),
                FormSeperatorBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
