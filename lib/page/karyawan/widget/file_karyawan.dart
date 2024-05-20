import 'package:drawer/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:drawer/constants/constants.dart';
import 'package:drawer/page/karyawan/widget/filecard.dart';

class fileKaryawan extends StatelessWidget {
  const fileKaryawan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Files",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          // fileCard(
          //   svgSrc: "assets/icons/media.svg",
          //   jabatan: "manager",
          // ),
          // fileCard(
          //   svgSrc: "assets/icons/media.svg",
          //   jabatan: "manager",
          // ),
          SizedBox(height: defaultPadding),
          Center(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.save),
                label: Text("Simpan"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
