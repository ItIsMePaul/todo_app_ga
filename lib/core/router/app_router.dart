import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_ga/features/Home/presentation/screen/home_screen.dart';
import 'package:todo_app_ga/features/task/model/task.dart';
import 'package:todo_app_ga/features/task/presentation/screen/add_task_screen.dart';
import 'package:todo_app_ga/features/task/presentation/screen/edit_task_screen.dart';
import 'package:todo_app_ga/features/task/presentation/screen/view_task_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/AddTask',
          page: AddTaskRoute.page,
        ),
        AutoRoute(
          path: '/EditTask',
          page: EditTaskRoute.page,
        ),
        AutoRoute(
          path: '/ViewTask',
          page: ViewTaskRoute.page,
        ),
      ];
}
