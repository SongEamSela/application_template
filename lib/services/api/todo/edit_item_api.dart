import 'package:application_template/services/api/todo/base_todo_api.dart';

class EditItemApi extends BaseToDoAPI {
  @override
  String nameInUrl() {
    return 'items';
  }
}
