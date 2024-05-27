import 'dart:io';

import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/data/services/users/users_bloc.dart';
import 'package:drawer/page/karyawan/widget/formkaryawan.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/file_proyek.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/filecard.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/formproyek.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class addProyek extends StatefulWidget {
  final String? id;
  final bool? isUpdate;
  Proyek? proyek;
  addProyek({this.id, this.isUpdate, this.proyek, super.key});

  @override
  State<addProyek> createState() => _addProyekState();
}

class _addProyekState extends State<addProyek> {
  List selectedUserId = [];
  bool isLoading = false;

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        String startText = DateFormat("yyyy-MM-dd").format(pickedDate);
        start.text = startText;
      });
    }
  }

  void selectDate2(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        String finishText = DateFormat("yyyy-MM-dd").format(pickedDate);
        finish.text = finishText;
      });
    }
  }

  String selectedManager = '';
  final MultiSelectController _controller = MultiSelectController();

  final nama = TextEditingController();
  final detail = TextEditingController();
  // final nilai = TextEditingController();
  final klien = TextEditingController();
  final start = TextEditingController();
  final finish = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate == true) {
      nama.text = widget.proyek!.nama!;
      detail.text = widget.proyek!.detail!;
      selectedManager = widget.proyek!.manager!;
      // nilai.text = widget.proyek!.nilai!.toString();
      klien.text = widget.proyek!.klien!;
      start.text = widget.proyek!.start!;
      finish.text = widget.proyek!.finish!;
    }
  }

  void storeProyek() async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> userData = {
        'nama': nama.text,
        'detail': detail.text,
        'manager': selectedManager,
        // 'nilai': nilai.text,
        'start': start.text,
        'finish': finish.text,
        'klien': klien.text,
      };

      final proyekService = ProyekServices();
      if (widget.isUpdate == false) {
        await proyekService.storeProyek(userData);
      } else {
        await proyekService.updateProyekById(widget.id ?? "", userData);
      }

      Fluttertoast.showToast(
          msg: widget.isUpdate == true
              ? "Update proyek successfully"
              : "Store proyek successfully",
          toastLength: Toast.LENGTH_LONG);
      context.read<MenuAppController>().setSelectedItem('dashboard');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to save proyek: $e", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                      const SizedBox(height: defaultPadding),
                      customformProyek(
                        title: "Nama Proyek",
                        controller: nama,
                      ),
                      customformProyek(
                        title: "Klien",
                        controller: klien,
                      ),
                      customformProyek(
                        title: "Detail",
                        controller: detail,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manager",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocProvider(
                            create: (context) =>
                                UsersBloc(userService: UserService())
                                  ..add(LoadUserManager()),
                            child: BlocBuilder<UsersBloc, UsersState>(
                              builder: (context, state) {
                                if (state is UsersLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is UsersLoaded) {
                                  final List<ValueItem<dynamic>>
                                      dropdownOptions = state.users
                                          .map((user) => ValueItem(
                                              label: user.name!,
                                              value: user.name))
                                          .toList();
                                  return MultiSelectDropDown(
                                    borderColor: Colors.white,
                                    fieldBackgroundColor: bgColor,
                                    dropdownBackgroundColor: secondaryColor,
                                    optionsBackgroundColor: secondaryColor,
                                    controller: _controller,
                                    onOptionSelected: (options) {
                                      setState(() {
                                        selectedManager =
                                            options[0].value.toString();
                                        print(selectedManager);
                                      });
                                      debugPrint(options.toString());
                                    },
                                    options: dropdownOptions,
                                    maxItems: 1,
                                    disabledOptions: const [
                                      ValueItem(label: 'Option 1', value: '1')
                                    ],
                                    selectionType: SelectionType.single,
                                    chipConfig: const ChipConfig(
                                        wrapType: WrapType.wrap),
                                    optionTextStyle:
                                        const TextStyle(fontSize: 16),
                                    selectedOptionIcon:
                                        const Icon(Icons.check_circle),
                                  );
                                } else if (state is UsersError) {
                                  return Center(
                                      child: Text('Error: ${state.error}'));
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      customform(
                        title: "Start",
                        controller: start,
                        isReadOnly: true,
                        onTap: () {
                          selectDate(context);
                        },
                      ),
                      customform(
                        title: "Finish",
                        controller: finish,
                        isReadOnly: true,
                        onTap: () {
                          selectDate2(context);
                        },
                      ),
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
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                ),
                                onPressed: () {
                                  storeProyek();
                                },
                                icon: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Icon(Icons.save),
                                label: isLoading
                                    ? Text("Menyimpan...")
                                    : Text("Simpan"),
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
      )),
    );
  }
}
