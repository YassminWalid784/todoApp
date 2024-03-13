import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/network_layer/firebase_utlis.dart';
import '../../../core/services/snack_bar_service.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../login/page/login_view.dart';
import '../../settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RegisterView extends StatelessWidget {
  static const String routeName = "register";

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingsProvider>(context);

    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: vm.isDark() ? const Color(0xFF060E1E) : const Color(0xFFDFECDB),
        image: const DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 120,
          centerTitle: true,
          title:  Text(local.createAccount),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: mediaQuery.height * 0.15),
                  Text(
                    local.fullName,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextField(
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    hint: local.enterYourFullName,
                    hintColor: Colors.black87,
                    suffixWidget: const Icon(Icons.person),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.youMustEnterYourName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    local.email,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: local.enterYourEmailAddress,
                    hintColor: Colors.black87,
                    suffixWidget: const Icon(Icons.email_rounded),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.youMustEnterYourName;
                      }

                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!regex.hasMatch(value)) {
                        return local.invalidEmailAddress;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    local.password,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextField(
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    hint: local.enterYourPassword,
                    hintColor: Colors.black87,
                    isPassword: true,
                    maxLines: 1,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.youMustEnterYourPassword;
                      }

                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                      if (!regex.hasMatch(value)) {
                        return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 6 characters long.";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    local.confirmPassword,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    hint: local.enterYourPassword,
                    hintColor: Colors.black87,
                    isPassword: true,
                    maxLines: 1,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.youMustEnterYourPassword;
                      }

                      if (value != passwordController.text) {
                        return local.passwordNotMatching;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseUtils()
                            .createNewAccount(
                          emailController.text,
                          passwordController.text,
                        )
                            .then((value) {
                          if (value == true) {
                            SnackBarService.showSuccessMessage(
                               local.accountSuccessfullyCreated);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginView.routeName,
                                  (route) => false,
                            );
                          }
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          local.createAccount,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 34,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}