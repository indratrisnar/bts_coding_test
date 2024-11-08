import 'package:bts_coding_test/pages/auth/login_page.dart';
import 'package:bts_coding_test/pages/auth/register_page.dart';
import 'package:bts_coding_test/pages/todo/add_todo_page.dart';
import 'package:bts_coding_test/pages/todo/checklist_item/add_checklist_item_page.dart';
import 'package:bts_coding_test/pages/todo/checklist_item/rename_checklist_item_page.dart';
import 'package:bts_coding_test/pages/todo/detail_todo_page.dart';
import 'package:bts_coding_test/pages/todo/todo_page.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future: DSession.getToken(),
              builder: (context, snapshot) {
                if (snapshot.data == null) return const LoginPage();
                return const TodoPage();
              },
            ),
        '/register': (context) => const RegisterPage(),
        '/todo/add': (context) => const AddTodoPage(),
        '/todo/detail': (context) {
          final todo = ModalRoute.of(context)!.settings.arguments as Map;
          return DetailTodoPage(todo: todo);
        },
        '/todo/update': (context) => const Scaffold(),
        '/checklistitem/add': (context) {
          final todoId = ModalRoute.of(context)!.settings.arguments as int;
          return AddChecklistItemPage(todoId: todoId);
        },
        '/checklistitem/rename': (context) {
          final data = ModalRoute.of(context)!.settings.arguments as Map;
          return RenameChecklistItemPage(data: data);
        },
      },
    );
  }
}
