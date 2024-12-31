import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_ga/core/router/app_router.dart';
import 'package:todo_app_ga/features/task/model/task.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';

@RoutePage()
class ViewTaskScreen extends ConsumerWidget {
  final Task task;
  const ViewTaskScreen({required this.task, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color(0xFFF8F0F0),
      child: Column(
        children: [
          Container(
            color: Color(0xFFCE2029),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: Color(0xFFCE2029),
                    child: Text(
                      'Task View',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Material(
            color: Color(0xFFF8F0F0),
            child: Container(
              child: Text(
                'Title: ${task.title}',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Material(
            color: Color(0xFFF8F0F0),
            child: Text(
              task.description ?? '',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Color(0xFF757575),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Material(
            color: Color(0xFFF8F0F0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Completed: ',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Color(0xFF757575),
                    ),
                  ),
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: null, // робить чекбокс неактивним
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 48,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          padding: EdgeInsets.symmetric(vertical: 12.0)),
                      onPressed: () async {
                        final notifier = ref.read(tasksProvider.notifier);
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
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
