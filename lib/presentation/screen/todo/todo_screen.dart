import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/presentation/widget/container/loading_container.dart';

import '../../../controller/todo_controller.dart';
import '../../widget/list_item/todo_list_item.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ref.read(todoProvider).tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    ref.read(todoProvider).tabController.dispose();
    ref.read(todoProvider).todoTextController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ref.read(todoProvider).scafoldState,
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.7),
        bottom: TabBar(
          controller: ref.read(todoProvider).tabController,
          tabs: const [
            Tab(
              text: 'Active Todos',
            ),
            Tab(text: 'Completed Todos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: ref.read(todoProvider).tabController,
        children: [
          // Active Todos
          if(ref.watch(todoProvider).isUnCompleteListEmpty==false)
            ...{
              ListView.builder(
                itemCount: ref.watch(todoProvider).unCompleteList.length,
                itemBuilder: (context, index) {
                  return TodoListItem(
                    text: ref.read(todoProvider).unCompleteList[index].title,
                    date: ref.read(todoProvider).unCompleteList[index].date,
                    checkBoxStatus: false,
                    onClickCheckBox: () {
                      ref
                          .read(todoProvider.notifier)
                          .onTodoComplete(index: index);
                    },
                  );
                },
              )
            }else ... {
           const LoadingContainer()
            },
          // Completed Todos
          if(ref.watch(todoProvider).isCompleteListEmpty==false)
            ...{
              ListView.builder(
                itemCount: ref.watch(todoProvider).completeList.length,
                itemBuilder: (context, index) {
                  return TodoListItem(
                    text: ref.read(todoProvider).completeList[index].title,
                    checkBoxStatus: true,
                    date: ref.read(todoProvider).completeList[index].date,
                    onClickCheckBox: () {
                      ref.read(todoProvider.notifier).onTodoBackToUncomplete(index:index);
                    },
                  );
                },
              )

            }else ...{
            LoadingContainer()
          }

        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets.copyWith(
                left: 5,
                right: 5,
              ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ref.read(todoProvider).todoTextController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a new todo',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white),
                onPressed: () {
                  ref.read(todoProvider).addTodo();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
