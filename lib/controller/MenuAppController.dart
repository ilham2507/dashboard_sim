import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedItem = 'dashboard';
  String? selectedItemId;
  bool? isUpdateItem;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setSelectedItem(String item, {String? id, bool? isUpdate}) {
    selectedItem = item;
    selectedItemId = id;
    isUpdateItem = isUpdate;
    notifyListeners();
  }
}
