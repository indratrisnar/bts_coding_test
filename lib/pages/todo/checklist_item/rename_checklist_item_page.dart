import 'package:bts_coding_test/datasources/checklist_item_datasource.dart';
import 'package:bts_coding_test/datasources/todo_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RenameChecklistItemPage extends StatefulWidget {
  const RenameChecklistItemPage({super.key, required this.data});
  final Map data;

  @override
  State<RenameChecklistItemPage> createState() =>
      _RenameChecklistItemPageState();
}

class _RenameChecklistItemPageState extends State<RenameChecklistItemPage> {
  final itemNameController = TextEditingController();

  void save() async {
    final itemName = itemNameController.text;

    final (success, message) = await ChecklistItemDatasource.rename(
      widget.data['todoId'],
      widget.data['item']['id'],
      itemName,
    );
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    Navigator.pop(context);
  }

  @override
  void initState() {
    itemNameController.text = widget.data['item']['name'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rename ChecklistItem'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DInputMix(
            controller: itemNameController,
          ),
          const Gap(20),
          FilledButton(
            onPressed: save,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
