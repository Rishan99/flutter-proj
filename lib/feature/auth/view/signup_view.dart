import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviehub/core/constant/app_defaults.dart';
import 'package:moviehub/core/helper/uiHelpers.dart';
import 'package:moviehub/core/utility/validator.dart';
import 'package:moviehub/dependency_inject.dart';
import 'package:moviehub/feature/auth/bloc/signup/signup_bloc.dart';
import 'package:moviehub/feature/auth/model/signup_model.dart';
import 'package:moviehub/widgets/custom_ink_well.dart';
import 'package:moviehub/widgets/form_seperator_box.dart';
import 'package:moviehub/widgets/form_title_widget.dart';
import 'package:moviehub/widgets/visibility_widget.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
    return BlocProvider(
      create: (_) => locator<SignupBloc>(),
      child: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            ProgressDialog pr = ProgressDialog(context);
            pr.show();
          } else {
            Navigator.pop(context);
            if (state is SignupSuccess) {
              displayToastSuccess("Registered successfully");
              Navigator.pop(context);
            } else if (state is SignupError) {
              displayToastFailure(state.message);
            }
          }
        },
        child: Scaffold(
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
                        if (!formKey.currentState!.validate()) return;
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupRequested(
                            SignupModel(
                              email: emailController.text,
                              name: nameController.text,
                              password: passwordController.text,
                            ),
                          ),
                        );
                      },
                      child: Text('Signup'),
                    ),
                    FormSeperatorBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
