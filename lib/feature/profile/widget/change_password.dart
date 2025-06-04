import 'package:flutter/material.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/utility/validator.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/services/user/user_service.dart';
import 'package:moviehub/shared/widgets/custom_ink_well.dart';
import 'package:moviehub/shared/widgets/form_seperator_box.dart';
import 'package:moviehub/shared/widgets/form_title_widget.dart';
import 'package:moviehub/shared/widgets/visibility_widget.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool obscurePassword = true;
  bool obscureNewPassword = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppDefaults.kPageSidePadding,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Enter your new password",
                  style: TextStyle(
                    color: Color(0xff92929D),
                  ),
                ),
                adaptableHeight(height: 40),
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
                FormSeperatorBox(),
                FormTitleWidget(
                  title: "Password",
                  child: TextFormField(
                    obscureText: obscurePassword,
                    controller: newPasswordController,
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
                FormSeperatorBox(),
                TextButton(
                    onPressed: () {
                      asyncCallHelperWithLoadingBar(context, processCall: () async {
                        return locator<UserService>().changePassword(passwordController.text, newPasswordController.text);
                      }, onSuccess: (x) {
                        displayToastSuccess(x.toString());
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Change Password")),
                FormSeperatorBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
