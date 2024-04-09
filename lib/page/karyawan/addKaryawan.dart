import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/dashboard/widget/team.dart';
import 'package:drawer/page/karyawan/widget/file_karyawan.dart';
import 'package:drawer/page/karyawan/widget/formkaryawan.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class addKaryawan extends StatelessWidget {
  const addKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: defaultPadding),
                        customform(title: "nama"),
                        customform(title: "Id"),
                        customform(title: "Jabatan"),
                        customform(title: "Email"),
                        customform(title: "Password Akun"),
                        customform(title: "Jenis Kelamin"),
                        customform(title: "Tanggal Lahir"),
                        customform(title: "No. Telp"),
                        customform(title: "Alamat"),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) fileKaryawan(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: fileKaryawan(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
