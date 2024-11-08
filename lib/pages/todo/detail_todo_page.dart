import 'package:bts_coding_test/datasources/checklist_item_datasource.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTodoPage extends StatefulWidget {
  const DetailTodoPage({super.key, required this.todo});
  final Map todo;

  @override
  State<DetailTodoPage> createState() => _DetailTodoPageState();
}

class _DetailTodoPageState extends State<DetailTodoPage> {
  final list = [].obs;

  void fetchAll() async {
    final (success, data) = await ChecklistItemDatasource.fetchAll(
      widget.todo['id'],
    );
    if (!success) return;

    list.value = data!;
  }

  void gotoAddChecklistItem() {
    Navigator.pushNamed(
      context,
      '/checklistitem/add',
      arguments: widget.todo['id'],
    ).then((value) {
      fetchAll();
    });
  }

  void gotoRenameChecklistItem(Map item) {
    Navigator.pushNamed(
      context,
      '/checklistitem/rename',
      arguments: {
        'item': item,
        'todoId': widget.todo['id'],
      },
    ).then((value) {
      fetchAll();
    });
  }

  void deleteChecklistItem(Map item) async {
    final (success, message) = await ChecklistItemDatasource.delete(
      widget.todo['id'],
      item['id'],
    );
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    fetchAll();
  }

  void updateStatus(Map item) async {
    final (success, message) = await ChecklistItemDatasource.updateStatus(
      widget.todo['id'],
      item['id'],
    );
    if (!success) return DInfo.toastError(message);

    DInfo.toastSuccess(message);
    fetchAll();
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
        title: Text(widget.todo['name']),
        actions: [
          IconButton(
            onPressed: gotoAddChecklistItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (list.isEmpty) return const Center(child: Text('Empty'));
        return ListView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final item = list[index];
            final itemName = item['name'];
            final isCheck = item['itemCompletionStatus'];
            return ListTile(
              leading: Checkbox(
                value: isCheck,
                onChanged: (value) {
                  updateStatus(item);
                },
              ),
              // onTap: () => gotoDetailTodo(item),
              title: Text(itemName),
              subtitle: InkWell(
                onTap: () => gotoRenameChecklistItem(item),
                child: const Text('Rename'),
              ),
              trailing: IconButton(
                onPressed: () => deleteChecklistItem(item),
                icon: const Icon(Icons.delete),
              ),
            );
          },
        );
      }),
    );
  }
}
