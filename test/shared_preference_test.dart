import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/local_storage/save_token_in_local_storage.dart';


void main(){
  group('shared preferences', () {
    group('get token', () {
      test('check if get token return empty string when sharedPreferences do not have any thing', () async{
        SharedPreferences.setMockInitialValues({});

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil(prefs: prefs);

        const expectedValue = '';
        final actualValue = await sharedPreferencesUtil.getTokenFromPref();

        expect(actualValue, expectedValue);
      });

      test('check if get token return empty string when their is no user logged in', () async{
        SharedPreferences.setMockInitialValues({'token':''});

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil(prefs: prefs);

        const expectedValue = '';
        final actualValue = await sharedPreferencesUtil.getTokenFromPref();

        expect(actualValue, expectedValue);
      });

      test('check if get token return token string when their is user logged in', () async{
        SharedPreferences.setMockInitialValues({'token':'1234w'});

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil(prefs: prefs);

        const expectedValue = '1234w';
        final actualValue = await sharedPreferencesUtil.getTokenFromPref();

        expect(actualValue, expectedValue);
      });
    });
    group('set token', () {
      test('check if setToken store the correct value in sharedPreferences', () async{
        SharedPreferences.setMockInitialValues({});

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil(prefs: prefs);

        await sharedPreferencesUtil.saveTokenLocally('1234w');

        const expectedValue = '1234w';
        final actualValue = await sharedPreferencesUtil.getTokenFromPref();

        expect(actualValue, expectedValue);
      });

      test('check if setToken store empty string value in sharedPreferences when user logout', () async{
        SharedPreferences.setMockInitialValues({});

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil(prefs: prefs);

        await sharedPreferencesUtil.saveTokenLocally('');

        const expectedValue = '';
        final actualValue = await sharedPreferencesUtil.getTokenFromPref();

        expect(actualValue, expectedValue);
      });
    });
  });
}