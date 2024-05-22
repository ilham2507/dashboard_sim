import 'package:drawer/controller/MenuAppController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getRoleId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); 
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); 
        } else {
          final roleId = snapshot.data ??
              0; 
          return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.asset("assets/photos/logo2.png"),
                ),
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashboard.svg",
                  press: () {
                    context
                        .read<MenuAppController>()
                        .setSelectedItem('dashboard');
                  },
                ),
                if (roleId != 5)
                  DrawerListTile(
                    title: "karyawan",
                    svgSrc: "assets/icons/menu_tran.svg",
                    press: () {
                      context
                          .read<MenuAppController>()
                          .setSelectedItem('karyawan');
                    },
                  ),
                DrawerListTile(
                  title: "Proyek",
                  svgSrc: "assets/icons/menu_task.svg",
                  press: () {
                    context.read<MenuAppController>().setSelectedItem('proyek');
                  },
                ),
                DrawerListTile(
                  title: "Profile",
                  svgSrc: "assets/icons/menu_profile.svg",
                  press: () {},
                ),
                DrawerListTile(
                  title: "Settings",
                  svgSrc: "assets/icons/menu_setting.svg",
                  press: () {},
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<int> _getRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role_id') ??
        0; // Nilai default dapat disesuaikan sesuai kebutuhan
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
