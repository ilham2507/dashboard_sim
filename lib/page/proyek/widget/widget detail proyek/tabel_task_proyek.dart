import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/penerima_proyek.dart';
import 'package:drawer/data/model/task_proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/data/services/proyek/task/task_service.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/proyek/add_task_proyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class tabelTaskProyek extends StatelessWidget {
  String? id;
  tabelTaskProyek({
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Data Pekerjaan",
                style: Theme.of(context).textTheme.titleMedium,
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return add_task(
                        id: id ?? "",
                        isUpdate: false,
                      );
                    },
                  );
                },
                icon: Icon(Icons.add_task),
                label: Text("Tambah Tugas"),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: BlocProvider(
                create: (context) =>
                    ProyekBloc(proyekServices: ProyekServices())
                      ..add(GetProyekById(userId: id ?? "")),
                child: BlocBuilder<ProyekBloc, ProyekState>(
                  builder: (context, state) {
                    if (state is ProyekLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ProyekError) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else if (state is ProyekByIdLoaded) {
                      final task = state.proyek.taskProyek;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: ScrollController(),
                        child: DataTable(
                          columnSpacing: defaultPadding,
                          columns: const [
                            DataColumn(
                              label: Text("Tugas"),
                            ),
                            DataColumn(
                              label: Text("Catatan"),
                            ),
                            DataColumn(
                              label: Text("Pekerja"),
                            ),
                            DataColumn(
                              label: Text("Start"),
                            ),
                            DataColumn(
                              label: Text("Deadline"),
                            ),
                            DataColumn(
                              label: Text("Status"),
                            ),
                            DataColumn(
                              label: Text("Nilai"),
                            ),
                            DataColumn(
                              label: Text("Aksi"),
                            ),
                          ],
                          // Rows
                          rows: List.generate(
                            task!.length,
                            (index) => recentTaskDataRow(
                                context, task[index], id ?? ""),
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

DataRow recentTaskDataRow(BuildContext context, TaskProyek task, String id) {
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  isUpdate: true,
                  idTask: id,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.tugas ?? ""),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  isUpdate: true,
                  idTask: id,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.catatan ?? ""),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  idTask: id,
                  isUpdate: true,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.penerimaProyek != null
                ? getPenerimaNames(task.penerimaProyek)
                : ""),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  idTask: id,
                  isUpdate: true,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.start ?? ""),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  idTask: id,
                  isUpdate: true,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.deadline ?? ""),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  idTask: id,
                  isUpdate: true,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.status ?? ""),
          ),
        ),
      ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task(
                  id: task.id.toString(),
                  idTask: id,
                  isUpdate: true,
                );
              },
            );
          },
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.nilai == null ? "0%" : "${task.nilai}%"),
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
                          deleteData(task.id.toString(), context);
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

String getPenerimaNames(List<PenerimaProyek>? penerimaProyek) {
  if (penerimaProyek == null || penerimaProyek.isEmpty) {
    return "";
  }
  return penerimaProyek.map((penerima) => penerima.user!.name).join(', ');
}

void deleteData(String id, BuildContext context) async {
  try {
    final taskServices = TaskService();
    await taskServices.deleteTasksById(id);
    Fluttertoast.showToast(
        msg: "Delete proyek successfully", toastLength: Toast.LENGTH_LONG);
    context.read<MenuAppController>().setSelectedItem('proyek');
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Failed to delete proyek: $e", toastLength: Toast.LENGTH_LONG);
  }
}
