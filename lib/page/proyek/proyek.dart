import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/proyek/widget/tabel_file_proyek.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:flutter/material.dart';

class proyek extends StatelessWidget {
  const proyek({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: defaultPadding),
                        proyekfile(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we don't want to show it
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
