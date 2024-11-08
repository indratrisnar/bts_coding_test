import 'package:bts_coding_test/datasources/checklist_item_datasource.dart';
import 'package:bts_coding_test/datasources/todo_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddChecklistItemPage extends StatefulWidget {
  const AddChecklistItemPage({super.key, required this.todoId});
  final int todoId;

  @override
  State<AddChecklistItemPage> createState() => _AddChecklistItemPageState();
}

class _AddChecklistItemPageState extends State<AddChecklistItemPage> {
  final itemNameController = TextEditingController();

  void addNew() async {
    final itemName = itemNameController.text;

    final (success, message) = await ChecklistItemDatasource.add(
      widget.todoId,
      itemName,
    );
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ChecklistItem'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DInputMix(
            controller: itemNameController,
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
