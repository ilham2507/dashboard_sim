import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/bloc/user_services.dart';
import 'package:drawer/data/services/bloc/users_bloc.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/karyawan/widget/topjudul.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                          ],
                          rows: List.generate(
                            users.length,
                            (index) => karyawanFileData(
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
          ),
        ],
      ),
    );
  }
}

DataRow karyawanFileDataRow(BuildContext context, karyawanfiledata fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 50,
            child: Text(fileInfo.id!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 200,
            child: Text(fileInfo.title!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 100,
            child: Text(fileInfo.position!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 100,
            child: Text(fileInfo.birth!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 130,
            child: Text(fileInfo.telp!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 130,
            child: Text(fileInfo.email!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 100,
            child: Text(fileInfo.gender!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail karyawan');
          },
          child: Container(
            width: 200,
            child: Text(fileInfo.address!),
          ),
        ),
      ),
    ],
  );
}

DataRow karyawanFileData(BuildContext context, User user, int id) {
  return DataRow(
    cells: [
      DataCell(Text(id.toString())),
      DataCell(Text(user.name)),
      DataCell(Text(user.role.name)),
      DataCell(Text(DateFormat('dd MMMM yyyy').format(user.tanggalLahir))),
      DataCell(Text(user.noTelp)),
      DataCell(Text(user.email)),
      DataCell(Text(user.jenisKelamin)),
      DataCell(Text(user.alamat)),
    ],
  );
}
