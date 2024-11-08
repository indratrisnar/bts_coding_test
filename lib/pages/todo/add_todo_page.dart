import 'package:bts_coding_test/datasources/todo_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final nameController = TextEditingController();

  void addNew() async {
    final name = nameController.text;

    final (success, message) = await TodoDatasource.add(name);
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo (Checklist)'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DInputMix(
            controller: nameController,
          ),
          const Gap(20),
          FilledButton(
            onPressed: addNew,
            child: const Text('Add New'),
          ),
        ],
      ),
    );
  }
}
