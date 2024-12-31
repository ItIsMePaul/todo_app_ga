import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/features/task/presentation/widgets/task_widget.dart';
import 'package:todo_app_ga/features/task/providers/task_providers.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);
    return tasksAsync.when(
      loading: () => CircularProgressIndicator(),
      data: (tasks) => Container(
        color: const Color(0xFFF8F0F0),
        child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskWidget(task: tasks[index]);
            }),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Loading error: $error'),
      ),
    );
  }
}
