import 'dart:io';

import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/data/services/roles/role_bloc.dart';
import 'package:drawer/data/services/roles/role_services.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/page/karyawan/widget/file_karyawan.dart';
import 'package:drawer/page/karyawan/widget/filecard.dart';
import 'package:drawer/page/karyawan/widget/formkaryawan.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class addKaryawan extends StatefulWidget {
  const addKaryawan({super.key});

  @override
  State<addKaryawan> createState() => _addKaryawanState();
}

class _addKaryawanState extends State<addKaryawan> {
  final MultiSelectController _controller = MultiSelectController();

  String? selectedRoleId;
  File? file;
  DateTime? selectedDate;

  final nama = TextEditingController();
  final username = TextEditingController();
  final nip = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final jk = TextEditingController();
  final tgl = TextEditingController();
  final notelp = TextEditingController();
  final alamat = TextEditingController();

  void selectDate(BuildContext _) async {
    final DateTime? pickedDate = await showDatePicker(
      context: _,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
    }
  }

  void storeUser() async {
    try {
      Map<String, dynamic> userData = {
        'role_id': selectedRoleId,
        'name': nama.text,
        'nip': nip.text,
        'email': email.text,
        'username': username.text,
        'password': password.text,
        'jenis_kelamin': jk.text,
        'tanggal_lahir': tgl.text,
        'no_telp': notelp.text,
        'alamat': alamat.text,
      };

      if (file != null) {
        String imagePath = file!.path;
        // Call UserService to store user
        final userService = UserService();
        await userService.storeUser(userData, imagePath);

        // Show success message
        Fluttertoast.showToast(
            msg: "Store user successfully", toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: "Please upload a profile photo",
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to save user: $e", toastLength: Toast.LENGTH_LONG);
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
                        SizedBox(height: defaultPadding),
                        customform(controller: nama, title: "Nama"),
                        customform(controller: nip, title: "Nip"),
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
                              BlocProvider(
                                create: (context) =>
                                    RoleBloc(roleServices: RoleServices())
                                      ..add(LoadRole()),
                                child: BlocBuilder<RoleBloc, RoleState>(
                                  builder: (context, state) {
                                    if (state is RoleLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is RoleLoaded) {
                                      final List<ValueItem<dynamic>>
                                          dropdownOptions = state.roles
                                              .map((role) => ValueItem(
                                                  label: role.name,
                                                  value: role.id))
                                              .toList();
                                      return MultiSelectDropDown(
                                        borderColor: Colors.white,
                                        fieldBackgroundColor: bgColor,
                                        dropdownBackgroundColor: secondaryColor,
                                        optionsBackgroundColor: secondaryColor,
                                        controller: _controller,
                                        onOptionSelected: (options) {
                                          setState(() {
                                            selectedRoleId =
                                                options[0].value.toString();
                                            print(selectedRoleId);
                                          });
                                          debugPrint(options.toString());
                                        },
                                        options: dropdownOptions,
                                        maxItems: 1,
                                        disabledOptions: const [
                                          ValueItem(
                                              label: 'Option 1', value: '1')
                                        ],
                                        selectionType: SelectionType.single,
                                        chipConfig: const ChipConfig(
                                            wrapType: WrapType.wrap),
                                        // dropdownHeight: 300,
                                        optionTextStyle:
                                            const TextStyle(fontSize: 16),
                                        selectedOptionIcon:
                                            const Icon(Icons.check_circle),
                                      );
                                    } else if (state is RoleError) {
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
                        ),
                        customform(controller: email, title: "Email"),
                        customform(controller: username, title: "Username"),
                        customform(controller: password, title: "Password"),
                        customform(controller: jk, title: "Jenis Kelamin"),
                        customform(controller: tgl, title: "Tanggal Lahir"),
                        customform(controller: notelp, title: "No. Telp"),
                        customform(controller: alamat, title: "Alamat"),
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
                              file: file,
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
                                  onPressed: () {
                                    storeUser();
                                  },
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
