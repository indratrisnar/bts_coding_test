import 'package:bts_coding_test/datasources/todo_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final list = [].obs;

  void fetchAll() async {
    final (success, data) = await TodoDatasource.fetchAll();
    if (!success) return;

    list.value = data!;
  }

  void gotoAddTodo() {
    Navigator.pushNamed(context, '/todo/add').then((value) {
      fetchAll();
    });
  }

  void gotoDetailTodo(Map todo) {
    Navigator.pushNamed(context, '/todo/detail', arguments: todo);
  }

  void deleteTodo(Map todo) async {
    final (success, message) = await TodoDatasource.delete(todo['id']);
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    fetchAll();
  }

  void logout() {
    DSession.removeToken().then((value) {
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  void initState() {
    fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo (Checklist)'),
        actions: [
          IconButton(
            onPressed: fetchAll,
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gotoAddTodo,
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (list.isEmpty) return const Center(child: Text('Empty'));
        return ListView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final item = list[index];
            final name = item['name'];
            final isCheck = item['checklistCompletionStatus'];

            return ListTile(
              leading: Checkbox(
                value: isCheck,
                onChanged: (value) {},
              ),
              onTap: () => gotoDetailTodo(item),
              title: Text(name),
              trailing: IconButton(
                onPressed: () => deleteTodo(item),
                icon: const Icon(Icons.delete),
              ),
            );
          },
        );
      }),
    );
  }
}
