import 'package:drawer/constants/responsive.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/page/dashboard/dashboard.dart';
import 'package:drawer/page/karyawan/karyawan.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedItem = context.watch<MenuAppController>().selectedItem;

    // Memberikan nilai awal null pada selectedPage
    Widget? selectedPage;

    if (selectedItem == 'dashboard') {
      selectedPage = dashboard();
    } else if (selectedItem == 'proyek') {
      selectedPage = proyek();
    } else if (selectedItem == 'karyawan') {
      selectedPage = karyawan();
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
