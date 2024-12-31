import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/core/router/app_router.dart';
import 'package:todo_app_ga/features/task/presentation/screen/task_screen.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: TaskScreen(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFCE2029),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => AutoRouter.of(context).push(AddTaskRoute())),
    );
  }
}
