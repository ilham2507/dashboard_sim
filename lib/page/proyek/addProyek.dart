import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/file_proyek.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/filecard.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/formproyek.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class addProyek extends StatefulWidget {
  const addProyek({super.key});

  @override
  State<addProyek> createState() => _addProyekState();
}

class _addProyekState extends State<addProyek> {
  final MultiSelectController _controller = MultiSelectController();

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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Team",
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
                                  ValueItem(label: 'Option 1', value: '1'),
                                  ValueItem(label: 'Option 2', value: '2'),
                                  ValueItem(label: 'Option 3', value: '3'),
                                  ValueItem(label: 'Option 4', value: '4'),
                                  ValueItem(label: 'Option 5', value: '5'),
                                  ValueItem(label: 'Option 6', value: '6'),
                                ],
                                // maxItems: 2,
                                disabledOptions: const [
                                  ValueItem(label: 'Option 1', value: '1')
                                ],
                                selectionType: SelectionType.multi,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 300,
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
                        customformProyek(title: "Start"),
                        customformProyek(title: "Deadline"),
                        customformProyek(title: "Selesai"),
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
                            fileCardProyek(
                              svgSrc: "assets/icons/media.svg",
                              jabatan: "manager",
                            ),
                            fileCardProyek(
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
