import 'package:crytojay/models/coins_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_auth.g.dart';

// class LocalStorage {
// static
@riverpod
Future<void> saveUser(SaveUserRef saveUserRef, List<String> currentUser) async {
  await prefs()!.setStringList('currentUser', currentUser);
}

@riverpod
String getUser(GetUserRef getUserRef) {
  return prefs()!.getString('currentUser') ?? "";
}

@riverpod
Future<bool> removeUser(RemoveUserRef removeUserRef) {
  return prefs()!.remove('currentUser');
}

@riverpod
Future<void> clearUser(ClearUserRef clearUserRef) {
  return prefs()!.clear();
}

class SharedPrefs {
  static SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

SharedPreferences? prefs() => SharedPrefs.prefs;
