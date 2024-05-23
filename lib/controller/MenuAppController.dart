import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/model/task_proyek.dart';
import 'package:drawer/data/model/user.dart';
import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedItem = 'dashboard';
  String? selectedItemId;
  Proyek? proyek;
  User? user;
  TaskProyek? task;
  bool? isUpdateItem;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setSelectedItem(String item,
      {String? id,
      bool? isUpdate,
      Proyek? proyeks,
      User? users,
      TaskProyek? tasks}) {
    selectedItem = item;
    selectedItemId = id;
    isUpdateItem = isUpdate;
    proyek = proyeks;
    user = users;
    task = tasks;
    notifyListeners();
  }
}
