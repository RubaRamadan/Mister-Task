import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/Backend/get_users.dart';
import 'package:task_manager_app/Core/functions.dart';

void main() async{
  await getUsers(1);


  group('input validation', () {
    test('field should be not empty', () {
      String value = 'ruba';
      String? message = InputValidator.validate(value);
      expect(message, null);
    });

    test('field should be not empty', () {
      String value = '';
      String? message = InputValidator.validate(value);
      expect(message, 'This field is required');
    });
  });
}
