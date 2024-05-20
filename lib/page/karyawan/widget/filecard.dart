import 'dart:io';

import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class fileCard extends StatefulWidget {
  fileCard({
    super.key,
    required this.svgSrc,
    required this.jabatan,
    required this.file,
  });

  final String svgSrc, jabatan;
  File? file;

  @override
  State<fileCard> createState() => _fileCardState();
}

class _fileCardState extends State<fileCard> {
  // File? _image;
  String? _imageName;

  Future getImageGalery() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (imageFile != null) {
        widget.file = File(imageFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
            child: SvgPicture.asset(widget.svgSrc),
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
              widget.file != null
                  ? Expanded(
                      child: Text(
                        widget.jabatan,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white70),
                      ),
                    )
                  : Text(
                      "Belum ada file dipilih",
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
                onPressed: getImageGalery,
                // context.read<MenuAppController>().setSelectedItem('add karyawan');
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
