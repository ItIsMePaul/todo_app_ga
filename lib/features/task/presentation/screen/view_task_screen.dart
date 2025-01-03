import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_ga/core/router/app_router.dart';
import 'package:todo_app_ga/features/common/presentation/screen/dialog_screen.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';

@RoutePage()
class ViewTaskScreen extends ConsumerWidget {
  final String taskId;
  const ViewTaskScreen({required this.taskId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(tasksProvider).value?.firstWhere(
          (t) => t.id == taskId,
        );

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color(0xFFF8F0F0),
      child: Column(
        children: [
          Container(
            color: Color(0xFFCE2029),
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      AutoRouter.of(context).back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: Material(
                      color: Color(0xFFCE2029),
                      child: Text(
                        'Title: ${task!.title}',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Color(0xFFF8F0F0),
                  child: Text(
                    'Description: ${task.description ?? ''}',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Color(0xFF757575),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Material(
                  color: Color(0xFFF8F0F0),
                  child: Row(
                    children: [
                      Text(
                        'Completed: ',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Color(0xFF757575),
                        ),
                      ),
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCE2029),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () {
                      AutoRouter.of(context)
                          .push(EditTaskRoute(editedTask: task));
                    },
                    child: Text('Edit task'),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFCE2029),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () async {
                        final notifier = ref.read(tasksProvider.notifier);
                        final shouldDelete = await showCustomDialog(
                              context: context,
                              title: 'Do you want to delete task?',
                              content:
                                  'Are you sure that you want to delete this task?',
                              confirmText: 'Delete',
                              cancelText: 'Cancel',
                              confirmColor: const Color(0xFFCE2029),
                              cancelColor: const Color(0xFF757575),
                            ) ??
                            false;
                        if (shouldDelete) {
                          notifier.deleteTask(task.id);
                        }
                      },
                      child: Text('Delete task')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
