import 'package:drawer/constants/responsive.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/page/dashboard/dashboard.dart';
import 'package:drawer/page/karyawan/addKaryawan.dart';
import 'package:drawer/page/karyawan/detailKaryawan.dart';
import 'package:drawer/page/karyawan/detailKaryawan.dart';
import 'package:drawer/page/karyawan/karyawan.dart';
import 'package:drawer/page/profil/profil.dart';
import 'package:drawer/page/proyek/addProyek.dart';
import 'package:drawer/page/proyek/detailProyek.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedItem = context.watch<MenuAppController>().selectedItem;
    final selectedItemId = context.watch<MenuAppController>().selectedItemId;
    final selectedItemUpdate = context.watch<MenuAppController>().isUpdateItem;
    final selectedItemProyek = context.watch<MenuAppController>().proyek;
    final selectedItemUser = context.watch<MenuAppController>().user;
    final selectedItemTask = context.watch<MenuAppController>().task;
    Widget? selectedPage;

    if (selectedItem == 'dashboard') {
      selectedPage = const dashboard();
    } else if (selectedItem == 'proyek') {
      selectedPage = const proyek();
    } else if (selectedItem == 'karyawan') {
      selectedPage = const karyawan();
    } else if (selectedItem == 'add karyawan' &&
        selectedItemId != null &&
        selectedItemUpdate != null &&
        selectedItemUser != null) {
      selectedPage = addKaryawan(
        id: selectedItemId,
        isUpdate: selectedItemUpdate,
        user: selectedItemUser,
      );
    } else if (selectedItem == 'add proyek' &&
        selectedItemId != null &&
        selectedItemUpdate != null &&
        selectedItemProyek != null) {
      selectedPage = addProyek(
        id: selectedItemId,
        isUpdate: selectedItemUpdate,
        proyek: selectedItemProyek,
      );
    } else if (selectedItem == 'detail karyawan' && selectedItemId != null) {
      selectedPage = detailKaryawan(idUser: selectedItemId);
    } else if (selectedItem == 'detail proyek' && selectedItemId != null) {
      selectedPage = detailProyek(
        id: selectedItemId,
      );
    } else if (selectedItem == 'profile') {
      selectedPage = profil();
    }

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: selectedPage ?? Container(),
            ),
          ],
        ),
      ),
    );
  }
}
