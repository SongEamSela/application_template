import 'package:application_template/services/api/user_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test call api', () async {
    UserApi api = UserApi();
    // var result = await api.fetchAll();
    // var result = await api.fetchOne(id: '2');
    // var result = await api.update(id: '2', body: {"name": "morpheus mon", "job": "zion resident"});
    // var result = await api.create(body: {"name": "morpheus susan", "job": "leader"});
    var result = await api.delete(id: '2');

    print(result);
  });
}
