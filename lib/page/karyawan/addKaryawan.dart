import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/karyawan/widget/file_karyawan.dart';
import 'package:drawer/page/karyawan/widget/filecard.dart';
import 'package:drawer/page/karyawan/widget/formkaryawan.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class addKaryawan extends StatefulWidget {
  const addKaryawan({super.key});

  @override
  State<addKaryawan> createState() => _addKaryawanState();
}

class _addKaryawanState extends State<addKaryawan> {
  final MultiSelectController _controller = MultiSelectController();

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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jabatan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MultiSelectDropDown(
                                borderColor: Colors.white,
                                fieldBackgroundColor: bgColor,
                                dropdownBackgroundColor: secondaryColor,
                                optionsBackgroundColor: secondaryColor,
                                controller: _controller,
                                onOptionSelected: (options) {
                                  debugPrint(options.toString());
                                },
                                options: const <ValueItem>[
                                  ValueItem(label: 'Direktur', value: '1'),
                                  ValueItem(label: 'Admin', value: '2'),
                                  ValueItem(label: 'Manager', value: '3'),
                                  ValueItem(label: 'Karyawan', value: '4'),
                                ],
                                maxItems: 1,
                                disabledOptions: const [
                                  ValueItem(label: 'Option 1', value: '1')
                                ],
                                selectionType: SelectionType.multi,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                // dropdownHeight: 300,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
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
                      child: Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                            fileCard(
                              svgSrc: "assets/icons/media.svg",
                              jabatan: "manager",
                            ),
                            fileCard(
                              svgSrc: "assets/icons/media.svg",
                              jabatan: "manager",
                            ),
                            SizedBox(height: defaultPadding),
                            Center(
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 1.5,
                                      vertical: defaultPadding /
                                          (Responsive.isMobile(context)
                                              ? 2
                                              : 1),
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
                      ),
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
