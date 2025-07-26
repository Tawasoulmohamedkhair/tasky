import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  factory PreferencesManager() {
    return _instance;
  }
  PreferencesManager._internal();

  late SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> getStringExists(String key) async =>
      _preferences.getString(key) != null;

  //set
  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  //get
  getString(String key) => _preferences.getString(key);
  getStringList(String key) => _preferences.getStringList(key);
  getBool(String key) => _preferences.getBool(key);
  getInt(String key) => _preferences.getInt(key);
  getDouble(String key) => _preferences.getDouble(key);

  //remove
  remove(String key) => _preferences.remove(key);
  //clear
  clear() => _preferences.clear();
}
