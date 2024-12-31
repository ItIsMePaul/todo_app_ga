// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddTaskScreen]
class AddTaskRoute extends PageRouteInfo<void> {
  const AddTaskRoute({List<PageRouteInfo>? children})
      : super(
          AddTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddTaskScreen();
    },
  );
}

/// generated route for
/// [EditTaskScreen]
class EditTaskRoute extends PageRouteInfo<EditTaskRouteArgs> {
  EditTaskRoute({
    required Task editedTask,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EditTaskRoute.name,
          args: EditTaskRouteArgs(
            editedTask: editedTask,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EditTaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTaskRouteArgs>();
      return EditTaskScreen(
        editedTask: args.editedTask,
        key: args.key,
      );
    },
  );
}

class EditTaskRouteArgs {
  const EditTaskRouteArgs({
    required this.editedTask,
    this.key,
  });

  final Task editedTask;

  final Key? key;

  @override
  String toString() {
    return 'EditTaskRouteArgs{editedTask: $editedTask, key: $key}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [ViewTaskScreen]
class ViewTaskRoute extends PageRouteInfo<ViewTaskRouteArgs> {
  ViewTaskRoute({
    required Task task,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ViewTaskRoute.name,
          args: ViewTaskRouteArgs(
            task: task,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewTaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewTaskRouteArgs>();
      return ViewTaskScreen(
        task: args.task,
        key: args.key,
      );
    },
  );
}

class ViewTaskRouteArgs {
  const ViewTaskRouteArgs({
    required this.task,
    this.key,
  });

  final Task task;

  final Key? key;

  @override
  String toString() {
    return 'ViewTaskRouteArgs{task: $task, key: $key}';
  }
}
