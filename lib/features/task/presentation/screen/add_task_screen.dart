import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_ga/features/task/model/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddTaskScreenState();
  }
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

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
          SizedBox(height: 48.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCE2029),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onPressed: () {
                      if (titleTextController.text.trim().isEmpty) {
                        return;
                      } else {
                        Task task = Task(
                          id: Uuid().v1(),
                          title: titleTextController.text.trim(),
                          description:
                              descriptionTextController.text.trim().isEmpty
                                  ? null
                                  : descriptionTextController.text.trim(),
                        );
                        final notifier = ref.watch(tasksProvider.notifier);
                        notifier.addTask(task);
                        AutoRouter.of(context).back();
                      }
                    },
                    child: Text('Add new task')),
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
