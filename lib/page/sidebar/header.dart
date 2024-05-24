import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedItem = context.watch<MenuAppController>().selectedItem;
    String pageTitle = '';

    // Memperbarui nilai pageTitle sesuai dengan selectedItem
    if (selectedItem == 'dashboard') {
      pageTitle = 'Dashboard';
    } else if (selectedItem == 'karyawan') {
      pageTitle = 'Karyawan';
    } else if (selectedItem == 'proyek') {
      pageTitle = 'Proyek';
    } else if (selectedItem == 'add karyawan') {
      pageTitle = 'Tambah Karyawan';
    } else if (selectedItem == 'add proyek') {
      pageTitle = 'Tambah Proyek';
    } else if (selectedItem == 'Detail Karyawan') {
      pageTitle = 'Detail Karyawan';
    } else if (selectedItem == 'detail proyek') {
      pageTitle = 'Detail Proyek';
    }

    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            pageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  Future<String> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading name'),
          );
        } else {
          final name = snapshot.data ?? 'Unknown User';
          return InkWell(
            onTap: () {
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      MediaQuery.of(context).size.width - 50, // right
                      50,
                      0,
                      0),
                  items: [
                    const PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "LogOut",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ]).then((value) {
                if (value != null) {
                  if (value == 0) {
                    _logout(context);
                  }
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: defaultPadding),
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/profile_pic.png",
                    height: 38,
                  ),
                  if (!Responsive.isMobile(context))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2,
                      ),
                      child: Text(name),
                    ),
                  InkWell(
                      onTap: () {},
                      child: const Icon(Icons.keyboard_arrow_down)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

void _logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('role_id');
  await prefs.remove('name');
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ));
  Fluttertoast.showToast(
      msg: "Berhasil logout", toastLength: Toast.LENGTH_LONG);
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
