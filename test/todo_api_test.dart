import 'package:application_template/services/api/todo/create_item_api.dart';
import 'package:application_template/services/api/todo/list_items_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test call todo api', () async {
    // Test USER API
    ListItemsApi api = ListItemsApi();
    var result = await api.fetchAll();
    // var result = await api.fetchOne(id: '2');
    // var result = await api.update(id: '2', body: {"name": "morpheus mon", "job": "zion resident"});
    // CreateItemApi api = CreateItemApi();
    // var result = await api.create(body: {
    //   "item": {"name": "Create from flutter"}
    // });
    // var result = await api.delete(id: '2');

    //Test REGISTER API
    // RegisterApi api = RegisterApi();
    // var result = await api.create(body: {"email": "eve.holt@reqres.in"});

    print(result);
  });
}
