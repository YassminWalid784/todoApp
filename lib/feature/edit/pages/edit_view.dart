import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/constants.dart';
import '../../../core/network_layer/firebase_utlis.dart';
import '../../../core/services/snack_bar_service.dart';
import '../../../core/utils/extract_date_time.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../main.dart';
import '../../../models/task_model.dart';
import '../../settings_provider.dart';

class EditView extends StatefulWidget {
  final TaskModel taskModel;
  static const String routeName = "edit";

  const EditView({super.key, required this.taskModel});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var local = AppLocalizations.of(context)!;
    var formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Stack(
            alignment: const Alignment(0, 2),
            children: [
              Container(
                width: mediaQuery.width,
                height: mediaQuery.height * 0.2,
                color: theme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 70),
                child: Text(
                  "ToDo List",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: vm.isDark() ? Colors.black : Colors.white,
                  ),
                ),
              ),
              Container(
                width: Constants.mediaQuery.width,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: vm.isDark() ? const Color(0xFF141922) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        local.editTask,
                        textAlign: TextAlign.center,
                        style: Constants.theme.textTheme.titleLarge?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        controller: titleController,
                        hint: local.thisIsTitle,
                        hintColor: Colors.grey.shade600,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return local.youMustEnterTaskTitle;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: descriptionController,
                        hint: local.taskDetails,
                        hintColor: Colors.grey.shade600,
                        maxLines: 3,
                        maxLength: 150,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return local.youMustEnterTaskDescription;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Text(
                        local.selectTime,
                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          vm.selectDateTime(context);
                        },
                        child: Text(
                          DateFormat.yMMMMd()
                              .format(extractDateTime(vm.selectedDate)),
                          textAlign: TextAlign.start,
                          style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              color: vm.isDark()
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var taskModel = TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              isDone: false,
                              dateTime: extractDateTime(vm.selectedDate),
                            );
                            EasyLoading.show();
                            FirebaseUtils().editTask(taskModel).then((value) {
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMessage(
                                  local.taskEditedSuccessfully);
                              navigatorKey.currentState!.pop();
                              vm.selectedDate = DateTime.now();
                            });
                          }
                        },
                        child: Text(
                          local.saveChanges,
                          style: Constants.theme.textTheme.bodyMedium?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
