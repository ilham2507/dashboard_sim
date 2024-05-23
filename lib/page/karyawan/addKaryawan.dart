import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/roles/role_bloc.dart';
import 'package:drawer/data/services/roles/role_services.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/data/services/users/users_bloc.dart';
import 'package:drawer/page/karyawan/widget/formkaryawan.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class addKaryawan extends StatefulWidget {
  final String? id;
  final bool? isUpdate;
  User? user;

  addKaryawan({this.id, this.isUpdate, this.user, super.key});

  @override
  State<addKaryawan> createState() => _addKaryawanState();
}

class _addKaryawanState extends State<addKaryawan> {
  final MultiSelectController _controller = MultiSelectController();

  String selectedRoleId = '';
  DateTime? selectedDate;
  bool isLoading = false;

  final nama = TextEditingController();
  final username = TextEditingController();
  final nip = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final jk = TextEditingController();
  final tgl = TextEditingController();
  final notelp = TextEditingController();
  final alamat = TextEditingController();

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      String tglnew = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        tgl.text = tglnew;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate == true) {
      nama.text = widget.user!.name!;
      username.text = widget.user!.username!;
      nip.text = widget.user!.nip!;
      email.text = widget.user!.email!;
      jk.text = widget.user!.jenisKelamin!;
      notelp.text = widget.user!.noTelp!;
      alamat.text = widget.user!.alamat!;
      tgl.text = DateFormat('yyyy-MM-dd').format(widget.user!.tanggalLahir!);
    }
  }

  void storeUser() async {
    setState(() {
      isLoading = true;
    });
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

      final userService = UserService();
      if (widget.isUpdate == true) {
        await userService.updateUserById(widget.id ?? "", userData);
      } else {
        await userService.storeUser(userData);
      }

      // Show success message
      Fluttertoast.showToast(
          msg: widget.isUpdate == true
              ? "Update user successfully"
              : "Store user successfully",
          toastLength: Toast.LENGTH_LONG);
      context.read<MenuAppController>().setSelectedItem('dashboard');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to save user: $e", toastLength: Toast.LENGTH_LONG);
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
                      customform(
                          onTap: () {
                            selectDate(context);
                          },
                          isReadOnly: true,
                          controller: tgl,
                          title: "Tanggal Lahir"),
                      customform(controller: notelp, title: "No. Telp"),
                      customform(controller: alamat, title: "Alamat"),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
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
                              storeUser();
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
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // if (!Responsive.isMobile(context))
                //   Expanded(
                //     flex: 2,
                //     child: Container(
                //       padding: EdgeInsets.all(defaultPadding),
                //       decoration: BoxDecoration(
                //         color: secondaryColor,
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(10)),
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "Files",
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SizedBox(height: defaultPadding),
                //           SizedBox(height: defaultPadding),
                //           Center(
                //             child: Container(
                //               width: double.infinity,
                //               child: ElevatedButton.icon(
                //                 style: TextButton.styleFrom(
                //                   padding: EdgeInsets.symmetric(
                //                     horizontal: defaultPadding * 1.5,
                //                     vertical: defaultPadding /
                //                         (Responsive.isMobile(context)
                //                             ? 2
                //                             : 1),
                //                   ),
                //                 ),
                //                 onPressed: () {
                //                   storeUser();
                //                 },
                //                 icon: isLoading
                //                     ? CircularProgressIndicator(
                //                         color: Colors.white,
                //                       )
                //                     : Icon(Icons.save),
                //                 label: isLoading
                //                     ? Text("Menyimpan...")
                //                     : Text("Simpan"),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

Container images(BuildContext context, VoidCallback onPressed) {
  return Container(
    margin: EdgeInsets.only(top: defaultPadding),
    padding: EdgeInsets.all(defaultPadding),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
      borderRadius: const BorderRadius.all(
        Radius.circular(defaultPadding),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: SvgPicture.asset("assets/icons/media.svg"),
        ),
        SizedBox(
            width: defaultPadding), // Spacer horizontal antara gambar dan teks
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
              onPressed: onPressed,
              icon: Icon(Icons.upload),
              label: Text("Upload Foto"),
            ),
          ],
        ),
      ],
    ),
  );
}
