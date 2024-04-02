import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/dashboard/widget/team.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/dashboard/widget/my_fields.dart';
import 'package:drawer/page/dashboard/widget/recent_files.dart';
import 'package:drawer/page/dashboard/widget/storage_details.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/material.dart';

class dashboard extends StatelessWidget {
  const dashboard({super.key});

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
                        MyFiles(),
                        SizedBox(height: defaultPadding),
                        RecentFiles(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) StorageDetails(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we don't want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: team(),
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
