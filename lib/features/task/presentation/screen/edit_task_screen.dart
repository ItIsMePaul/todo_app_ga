import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_ga/features/common/presentation/screen/dialog_screen.dart';
import 'package:todo_app_ga/features/task/model/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';

@RoutePage()
class EditTaskScreen extends ConsumerStatefulWidget {
  final Task editedTask;
  const EditTaskScreen({required this.editedTask, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EditTaskScreenState();
  }
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  void initState() {
    titleTextController.text = widget.editedTask.title;
    descriptionTextController.text = widget.editedTask.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color(0xFFF8F0F0),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 32.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: TextField(
                controller: titleTextController,
                cursorColor: Color(0xFFCE2029),
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter title',
                  labelStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  floatingLabelStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color(0xFFCE2029),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCE2029)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: TextField(
                controller: descriptionTextController,
                cursorColor: Color(0xFFCE2029),
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter description',
                  labelStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  floatingLabelStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Color(0xFFCE2029),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCE2029)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Material(
                  color: Color(0xFFF8F0F0),
                  child: Text(
                    'Completed: ',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Color(0xFFCE2029),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Material(
                    color: Color(0xFFF8F0F0),
                    child: Checkbox(
                      value: widget.editedTask.isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.editedTask.isCompleted = value ?? false;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Color(0xFFCE2029),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      side: BorderSide(
                        color: Color(0xFFCE2029),
                        width: 2.0,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 48.0),
          Row(
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
                    onPressed: () async {
                      final navigator = AutoRouter.of(context);
                      final notifier = ref.watch(tasksProvider.notifier);
                      if (!context.mounted) return;
                      final shouldUpdate = await showCustomDialog(
                            context: context,
                            title: 'Do you want to update the task?',
                            content:
                                'Are you sure that you want to update this task?',
                            confirmText: 'Update',
                            cancelText: 'Cancel',
                            confirmColor: const Color(0xFFCE2029),
                            cancelColor: const Color(0xFF757575),
                          ) ??
                          false;
                      if (!context.mounted) return;
                      if (shouldUpdate) {
                        notifier.updateTask(
                          widget.editedTask.copyWith(
                            title: titleTextController.text,
                            description: descriptionTextController.text,
                            isCompleted: widget.editedTask.isCompleted,
                          ),
                        );
                        navigator.back();
                      }
                    },
                    child: Text('Update task')),
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
                    onPressed: () {
                      AutoRouter.of(context).back();
                    },
                    child: Text('Cancel')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
