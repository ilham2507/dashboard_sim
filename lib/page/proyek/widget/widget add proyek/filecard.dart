import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class fileCardProyek extends StatelessWidget {
  const fileCardProyek({
    Key? key,
    required this.svgSrc,
    required this.jabatan,
  }) : super(key: key);

  final String svgSrc, jabatan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Mengatur teks agar berada di kiri
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: SvgPicture.asset(svgSrc),
          ),
          SizedBox(
              width:
                  defaultPadding), // Spacer horizontal antara gambar dan teks
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Mengatur teks agar berada di kiri
            children: [
              Text(
                "Foto Profil",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                jabatan,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  // context.read<MenuAppController>().setSelectedItem('add karyawan');
                },
                icon: Icon(Icons.upload),
                label: Text("Upload Foto"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
