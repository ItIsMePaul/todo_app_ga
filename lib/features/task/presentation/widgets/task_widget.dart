import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/core/router/app_router.dart';
import 'package:todo_app_ga/features/task/model/task.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskWidget extends ConsumerWidget {
  final Task task;
  const TaskWidget({required this.task, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(tasksProvider.notifier);
    return GestureDetector(
      onLongPress: () {
        AutoRouter.of(context).push(ViewTaskRoute(task: task));
      },
      child: Dismissible(
        key: Key(task.id),
        background: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        secondaryBackground: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        direction: DismissDirection.horizontal,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            await AutoRouter.of(context).push(EditTaskRoute(editedTask: task));
            return false;
          } else if (direction == DismissDirection.endToStart) {
            final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(
                        color: Color(0xFFFFE4E4),
                        width: 2.0,
                      ),
                    ),
                    title: Text(
                      'Do you want to delete task?',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    content: Text(
                      'Are you sure that you want to delete this task?',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF757575),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFFCE2029),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  Text(
                    task.title,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  )
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
}
