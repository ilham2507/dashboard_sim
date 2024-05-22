import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/data/services/users/users_bloc.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/karyawan/detailKaryawan.dart';
import 'package:drawer/page/karyawan/widget/topjudul.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class karyawanfile extends StatefulWidget {
  const karyawanfile({
    Key? key,
  }) : super(key: key);

  @override
  State<karyawanfile> createState() => _karyawanfileState();
}

class _karyawanfileState extends State<karyawanfile> {
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
          topjudulkaryawan(),
          SizedBox(
            width: double.infinity,
            child: BlocProvider(
              create: (context) =>
                  UsersBloc(userService: UserService())..add(LoadUser()),
              child: BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UsersLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UsersError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is UsersLoaded) {
                    final users = state.users;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: defaultPadding,
                        columns: const [
                          DataColumn(label: Text("No")),
                          DataColumn(label: Text("Name")),
                          DataColumn(label: Text("Position")),
                          DataColumn(label: Text("Birth")),
                          DataColumn(label: Text("No. Telp")),
                          DataColumn(label: Text("Email")),
                          DataColumn(label: Text("Gender")),
                          DataColumn(label: Text("Address")),
                          DataColumn(label: Text("Aksi")),
                        ],
                        rows: List.generate(
                          users.length,
                          (index) => karyawanFileDataRow(
                              context, users[index], index + 1),
                        ),
                      ),
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow karyawanFileDataRow(BuildContext context, User user, int id) {
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 50,
            child: Text(id.toString()),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 100,
            child: (Text(user.name)),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 100,
            child: Text(user.role!.name),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 130,
            child: Text(DateFormat('dd MMMM yyyy').format(user.tanggalLahir)),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 130,
            child: Text(user.noTelp),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 250,
            child: Text(user.email),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 100,
            child: Text(user.jenisKelamin),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan', id: user.id.toString());
          },
          child: Container(
            width: 100,
            child: Text(user.alamat),
          ),
        ),
      ),
      DataCell(
        SizedBox(
          width: 100,
          child: IconButton(
              color: Colors.red,
              onPressed: () {
                AwesomeDialog(
                        width: 500,
                        context: context,
                        animType: AnimType.scale,
                        title: "Warning",
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          deleteData(user.id.toString(), context);
                        },
                        desc: "Are you sure to delete the data?")
                    .show();
              },
              icon: Icon(Icons.remove_circle_outline_sharp)),
        ),
      ),
    ],
  );
}

DataRow karyawanFileData(BuildContext context, User user, int id) {
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(id.toString()),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(user.name),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(user.role!.name),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(DateFormat('dd MMMM yyyy').format(user.tanggalLahir)),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(user.noTelp),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(user.email),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(user.jenisKelamin),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    detailKaryawan(idUser: user.id.toString()),
              ),
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(user.alamat),
          ),
        ),
      ),
      DataCell(
        SizedBox(
          width: 100,
          child: IconButton(
              color: Colors.red,
              onPressed: () {
                AwesomeDialog(
                        width: 500,
                        context: context,
                        animType: AnimType.scale,
                        title: "Warning",
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          deleteData(user.id.toString(), context);
                        },
                        desc: "Are you sure to delete the data?")
                    .show();
              },
              icon: Icon(Icons.remove_circle_outline_sharp)),
        ),
      ),
    ],
  );
}

void deleteData(String id, BuildContext context) async {
  try {
    final userServices = UserService();
    await userServices.deleteUserById(id);
    Fluttertoast.showToast(
        msg: "Delete user successfully", toastLength: Toast.LENGTH_LONG);
    context.read<MenuAppController>().setSelectedItem('karyawan');
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Failed to delete proyek: $e", toastLength: Toast.LENGTH_LONG);
  }
}
