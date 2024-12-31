import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_ga/core/providers/database_providers.dart';
import 'package:todo_app_ga/features/task/repositories/sembast_task_repository.dart';
import 'package:todo_app_ga/features/task/model/task.dart';

final taskRepositoryProvider =
    Provider<AsyncValue<SembastTaskRepository>>((ref) {
  final databaseAsync = ref.watch(databaseProvider);
  return databaseAsync.when(
    data: (database) => AsyncValue.data(SembastTaskRepository(database)),
    error: (error, stackTrace) =>
        throw Exception('Failed to initialize database: $error'),
    loading: () => const AsyncValue.loading(),
  );
});

final tasksProvider =
    StateNotifierProvider<TaskNotifier, AsyncValue<List<Task>>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

class TaskNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final AsyncValue<SembastTaskRepository> _repository;
  TaskNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      state = const AsyncValue.loading();
      final repository = _repository.valueOrNull;
      if (repository == null) {
        throw Exception('Repository not initialized');
      }
      final tasks = await repository.getAllTask();
      state = AsyncValue.data(tasks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final repository = _repository.valueOrNull;
      if (repository == null) {
        throw Exception('Repository not initialized');
      }
      await repository.updateTask(task);
      state = AsyncValue.data(
        state.value!.map((taskItem) {
          if (taskItem.id == task.id) {
            return task;
          }
          return taskItem;
        }).toList(),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    try {
      Task markedTask = task.markAsCompleted();
      await updateTask(markedTask);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final repository = _repository.valueOrNull;
      if (repository == null) {
        throw Exception('Repository not initialized');
      }
      state = AsyncValue.data([...state.value ?? [], task]);
      await repository.addTask(task);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final repository = _repository.valueOrNull;
      if (repository == null) {
        throw Exception('Repository not initialized');
      }
      repository.deleteTask(id);
      state = AsyncValue.data(
          state.value?.where((task) => task.id != id).toList() ?? []);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
