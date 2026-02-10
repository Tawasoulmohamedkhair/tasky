

import 'package:flutter/cupertino.dart';
import 'package:tasky/core/constant/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/data/models/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username = "Default";
  String? userImagePath;
 
 
 

  init() {
    loadData();
  }

  void loadData() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImagePath = PreferencesManager().getString(StorageKey.userimage);

    notifyListeners();
  }


}
