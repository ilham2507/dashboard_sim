import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/file_proyek.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/formproyek.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class addProyek extends StatelessWidget {
  const addProyek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        customformProyek(title: "Nama Proyek"),
                        customformProyek(title: "Klien"),
                        customformProyek(title: "Manager"),
                        customformProyek(title: "Team"),
                        customformProyek(title: "Start"),
                        customformProyek(title: "Deadline"),
                        customformProyek(title: "Selesai"),
                        customformProyek(title: "Status"),
                        customformProyek(title: "Deskripsi"),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) fileproyek(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: fileproyek(),
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
