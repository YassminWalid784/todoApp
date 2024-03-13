import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../core/config/constants.dart';
import '../../../core/network_layer/firebase_utlis.dart';
import '../../../core/services/snack_bar_service.dart';
import '../../../models/task_model.dart';
import '../../edit/pages/edit_view.dart';
import '../../settings_provider.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      decoration: BoxDecoration(
        // color: const Color(0xFFFE4A49),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.29,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) =>  EditView(taskModel: taskModel,)),
                );
              },
              backgroundColor: const Color(0xFF61E757),
              borderRadius: BorderRadius.circular(12),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: local.edit,
            ),
          ],
        ),
        startActionPane: ActionPane(
          extentRatio: 0.29,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils().deleteTask(taskModel).then((value) {
                  EasyLoading.dismiss();
                  SnackBarService.showSuccessMessage(
                      local.taskDeletedSuccessfully);
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              borderRadius: BorderRadius.circular(12),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: local.delete,
            ),
          ],
        ),
        child: Container(
          height: 115,
          width: mediaQuery.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: vm.isDark() ? const Color(0x0ff14922) : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 90,
                decoration: BoxDecoration(
                  color: taskModel.isDone == true
                      ? Colors.green
                      : theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: taskModel.isDone == true
                            ? Colors.green
                            : theme.primaryColor,
                      ),
                    ),
                    Text(
                      taskModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 18,
                          color: vm.isDark()
                              ? const Color(0x0ff14922)
                              : Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat.yMMMMd().format(taskModel.dateTime),
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (taskModel.isDone)
                Text(
                  local.done,
                  style: Constants.theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.green, fontSize: 24),
                ),
              if (!taskModel.isDone)
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    FirebaseUtils().updateTask(taskModel).then((value) {
                      EasyLoading.dismiss();
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 2),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 35,
                        color: Colors.white,
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
