import 'package:application_template/mixin/toast.dart';
import 'package:application_template/services/api/todo/create_item_api.dart';
import 'package:application_template/services/api/todo/edit_item_api.dart';
import 'package:application_template/services/api/todo/list_items_api.dart';
import 'package:application_template/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TodoHome extends HookConsumerWidget with Toast {
  const TodoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(todoProvider);
    if (notifier.isloading) {
      showLoading();
    } else {
      hideLoading();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'ToDo List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade400,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Text(
                  'Daily Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                child: notifier.item == null
                    ? Container()
                    : ListView.builder(
                        itemCount: notifier.item?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return taskItem(notifier.item?[index], notifier);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
            builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Padding(
                //Add padding when show keyboard
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'ADD TASK',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: CustomTextFeild(
                          controller: notifier.taskController,
                          hintText: 'Enter your task',
                        ),
                      ),
                      MaterialButton(
                        height: 50,
                        color: Colors.green,
                        onPressed: () async {
                          var result = await notifier.createTask(task: notifier.taskController.text);
                          if (result != null) {
                            Navigator.pop(context);
                            notifier.loadItemList();
                          }
                          notifier.taskController.clear();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Add',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget taskItem(ItemModel item, TodoNotifier notifier) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          print(item.id);

          var result = notifier.deleteTask(taskId: item.id!);
          if (result != null) {}
        }),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              var result = notifier.deleteTask(taskId: item.id!);
              if (result != null) {}
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () async {
          var result = await notifier.updateTask(taskId: item.id!, isComplete: item.completed!);
          if (result != null) {}
          notifier.loadItemList();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey.shade300),
              bottom: BorderSide(width: 0.5, color: Colors.grey.shade300),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              item.completed == false ? checkList(false) : checkList(true),
              Expanded(
                child: Container(
                  height: 64,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${item.name}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkList(bool isChecked) {
    if (isChecked) {
      return Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.grey)),
      );
    }
  }
}

class TodoNotifier extends ChangeNotifier {
  ListItemsApi api = ListItemsApi();
  CreateItemApi itemApi = CreateItemApi();
  EditItemApi editApi = EditItemApi();
  bool isloading = false;
  List<dynamic>? item;
  TextEditingController taskController = TextEditingController();
  loadItemList() async {
    setLoading();
    var result = await api.fetchAll();

    item = result.map((element) {
      ItemModel itemModel = ItemModel.fromJson(element);
      return itemModel;
    }).toList();

    Future.delayed(Duration(seconds: 2), () {
      setLoading();
    });
  }

  createTask({required String task}) async {
    if (task.isEmpty) return;

    var body = {
      'item': {'name': task}
    };
    setLoading();
    var result = await itemApi.create(body: body);
    setLoading();
    return result;
  }

  deleteTask({required int taskId}) {
    // EditItemApi api = EditItemApi(id: taskId);
    var result = editApi.delete(id: taskId.toString());
    return result;
  }

  updateTask({required int taskId, required bool isComplete}) {
    setLoading();
    var body = {
      'item': {'completed': !isComplete},
    };
    var result = editApi.update(id: taskId.toString(), body: body);
    setLoading();
    return result;
  }

  setLoading() {
    isloading = !isloading;
    notifyListeners();
  }
}

final todoProvider = ChangeNotifierProvider<TodoNotifier>((ref) {
  final notifier = TodoNotifier();
  notifier.loadItemList();
  return notifier;
});

class ItemModel {
  int? id;
  String? name;
  bool? completed;

  ItemModel({
    this.id,
    this.name,
    this.completed,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        name: json["name"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "completed": completed,
      };
}
