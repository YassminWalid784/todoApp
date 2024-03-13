import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../core/config/constants.dart';
import '../core/network_layer/firebase_utlis.dart';
import '../core/services/snack_bar_service.dart';
import '../core/utils/extract_date_time.dart';
import '../core/widgets/custom_text_field.dart';
import 'settings_provider.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import 'package:todo_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var vm = Provider.of<SettingsProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Container(
      width: Constants.mediaQuery.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      decoration:  BoxDecoration(
        color: vm.isDark() ?const Color(0xFF141922):Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              local.addNewTask,
              textAlign: TextAlign.center,
              style: Constants.theme.textTheme.titleLarge
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 25),
            CustomTextField(
              controller: titleController,
              hint: local.enterTaskTitle,
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
              hint: local.enterTaskDescription,
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
              style: Constants.theme.textTheme.bodyMedium
                  ?.copyWith(color: vm.isDark() ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                vm.selectDateTime(context);
              },
              child: Text(
                DateFormat.yMMMMd().format(extractDateTime(vm.selectedDate)),
                textAlign: TextAlign.center,
                style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
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
                  FirebaseUtils().addNewTask(taskModel).then((value) {
                    EasyLoading.dismiss();
                    SnackBarService.showSuccessMessage(
                       local.taskSuccessfullyCreated);
                    navigatorKey.currentState!.pop();
                    vm.selectedDate = DateTime.now();
                  });
                }
              },
              child: Text(
               local.addTask,
                style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}