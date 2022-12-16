import 'package:application_template/services/api/todo/base_todo_api.dart';

class ListItemsApi extends BaseToDoAPI {
  @override
  String nameInUrl() {
    return 'items';
  }
}
