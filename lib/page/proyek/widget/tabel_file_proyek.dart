import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/proyek/widget/topjudulproyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class proyekfile extends StatelessWidget {
  const proyekfile({
    Key? key,
  }) : super(key: key);

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
          topjudulproyek(),
          SizedBox(
            width: double.infinity,
            child: BlocProvider(
                create: (context) =>
                    ProyekBloc(proyekServices: ProyekServices())
                      ..add(LoadProyek()),
                child: BlocBuilder<ProyekBloc, ProyekState>(
                  builder: (context, state) {
                    if (state is ProyekLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ProyekError) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else if (state is ProyekLoaded) {
                      final proyeks = state.proyeks;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: ScrollController(),
                        child: DataTable(
                          columnSpacing: defaultPadding,
                          columns: const [
                            DataColumn(
                              label: Text("No"),
                            ),
                            DataColumn(
                              label: Text("Project Name"),
                            ),
                            DataColumn(
                              label: Text("Klien"),
                            ),
                            DataColumn(
                              label: Text("Manager"),
                            ),
                            DataColumn(
                              label: Text("Start"),
                            ),
                            DataColumn(
                              label: Text("Finished"),
                            ),
                            DataColumn(
                              label: Text("Nilai"),
                            ),
                            DataColumn(
                              label: Text("Aksi"),
                            ),
                          ],
                          rows: List.generate(
                            proyeks.length,
                            (index) => proyekFileDataRow(
                                context, proyeks[index], index + 1),
                          ),
                        ),
                      );
                    }

                    return SizedBox();
                  },
                )),
          ),
        ],
      ),
    );
  }
}

void deleteData(String id, BuildContext context) async {
  try {
    final proyekService = ProyekServices();
    await proyekService.deleteProyekById(id);
    Fluttertoast.showToast(
        msg: "Delete proyek successfully", toastLength: Toast.LENGTH_LONG);
    context.read<MenuAppController>().setSelectedItem('dashboard');
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Failed to delete proyek: $e", toastLength: Toast.LENGTH_LONG);
  }
}

DataRow proyekFileDataRow(BuildContext context, Proyek proyek, int id) {
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail proyek', id: proyek.id.toString());
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
                .setSelectedItem('detail proyek', id: proyek.id.toString());
          },
          child: Container(
            width: 200,
            child: Text(proyek.nama!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail proyek', id: proyek.id.toString());
          },
          child: Container(
            width: 200,
            child: Text(proyek.klien!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail proyek', id: proyek.id.toString());
          },
          child: Container(
            width: 200,
            child: Text(proyek.manager!),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail proyek', id: proyek.id.toString());
          },
          child: Container(
            width: 200,
            child: Text(DateFormat('EEEE, MMMM d, y')
                .format(DateTime.parse(proyek.start!))),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail proyek', id: proyek.id.toString());
          },
          child: Container(
            width: 200,
            child: Text(DateFormat('EEEE, MMMM d, y')
                .format(DateTime.parse(proyek.finish!))),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            context
                .read<MenuAppController>()
                .setSelectedItem('detail proyek', id: proyek.id.toString());
          },
          child: Container(
            width: 100,
            child: Text("${proyek.nilai}%"),
          ),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
                color: Colors.blue,
                onPressed: () {
                  context.read<MenuAppController>().setSelectedItem(
                      'add proyek',
                      id: proyek.id.toString(),
                      isUpdate: true);
                },
                icon: Icon(Icons.edit_note_outlined)),
            IconButton(
                color: Colors.red,
                onPressed: () {
                  AwesomeDialog(
                          width: 500,
                          context: context,
                          animType: AnimType.scale,
                          title: "Warning",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            deleteData(proyek.id.toString(), context);
                          },
                          desc: "Are you sure to delete the data?")
                      .show();
                },
                icon: Icon(Icons.remove_circle_outline_sharp)),
          ],
        ),
      ),
    ],
  );
}
