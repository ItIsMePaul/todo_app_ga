import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/core/router/app_router.dart';
import 'package:todo_app_ga/features/common/presentation/screen/dialog_screen.dart';
import 'package:todo_app_ga/features/common/presentation/widget/custom_text_widget.dart';
import 'package:todo_app_ga/features/task/model/task.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';

class TaskWidget extends ConsumerWidget {
  final Task task;
  const TaskWidget({required this.task, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(tasksProvider.notifier);
    return GestureDetector(
      onLongPress: () {
        AutoRouter.of(context).push(ViewTaskRoute(taskId: task.id));
      },
      child: Dismissible(
        key: Key(task.id),
        background: dismissibleBackgroundWidget(
          radius: 10.0,
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: 20.0,
          icon: Icon(
            Icons.edit,
            color: Colors.white,
            size: 32,
          ),
        ),
        secondaryBackground: dismissibleBackgroundWidget(
          radius: 10.0,
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: 20.0,
          icon: Icon(
            Icons.delete,
            color: Colors.white,
            size: 32,
          ),
        ),
        direction: DismissDirection.horizontal,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            await AutoRouter.of(context).push(EditTaskRoute(editedTask: task));
            return false;
          } else if (direction == DismissDirection.endToStart) {
            final shouldDelete = await showCustomDialog(
                  context: context,
                  title: 'Do you want to delete task?',
                  content: 'Are you sure that you want to delete this task?',
                  confirmText: 'Delete',
                  cancelText: 'Cancel',
                  confirmColor: const Color(0xFFCE2029),
                  cancelColor: const Color(0xFF757575),
                ) ??
                false;
            if (shouldDelete) {
              notifier.deleteTask(task.id);
            }
            return shouldDelete;
          }
          return false;
        },
        movementDuration: const Duration(milliseconds: 200),
        dismissThresholds: {
          DismissDirection.endToStart: 0.6,
          DismissDirection.startToEnd: 0.6,
        },
        child: Container(
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFFFE4E4),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFFFFFF),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: task.title,
                    fontSize: 18,
                    color: Color(0xFF212121),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Checkbox(
                  checkColor: Color(0xFFE0E0E0),
                  activeColor: Color(0xFF9E1B21),
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    notifier.toggleTaskCompletion(task);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox dismissibleBackgroundWidget(
      {required double radius,
      required Color color,
      required Alignment alignment,
      required double padding,
      required Icon icon}) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: icon,
      ),
    );
  }
}
