import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/network_layer/firebase_utlis.dart';
import '../../../core/services/snack_bar_service.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../layout_view.dart';
import '../../register/page/register_view.dart';
import '../../settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "login";

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
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
          title:  Text(local.login),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: mediaQuery.height * 0.15),
                Text(
                 local.welcomeBack,
                  textAlign: TextAlign.start,
                  style:
                  theme.textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 30),
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
                      return local.youMustEnterYourEmailAddress;
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
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseUtils()
                          .signIN(emailController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          SnackBarService.showSuccessMessage(
                              local.yourLoggedInSuccessfully);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LayoutView.routeName,
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
                        local.login,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      local.or,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RegisterView.routeName,
                        );
                      },
                      child: Text(
                        local.createNewAccount,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}