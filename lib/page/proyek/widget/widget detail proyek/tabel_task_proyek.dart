import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/data/model/task_proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/proyek/add_task_proyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      return add_task();
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
                          ],
                          // Rows
                          rows: List.generate(
                            task!.length,
                            (index) => recentTaskDataRow(context, task[index]),
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

DataRow recentTaskDataRow(BuildContext context, TaskProyek task) {
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task();
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
                return add_task();
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
      // DataCell(
      //   GestureDetector(
      //     onTap: () {
      //       showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return add_task();
      //         },
      //       );
      //     },
      //     child: Container(
      //       padding: EdgeInsets.symmetric(horizontal: 10),
      //       child: Text(task.pekerja ?? ""),
      //     ),
      //   ),
      // ),
      DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task();
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
                return add_task();
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
                return add_task();
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
                return add_task();
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
    ],
  );
}

DataRow recentTaskData(BuildContext context, List<TaskProyek> taskList) {
  return DataRow(
    cells: List.generate(
      taskList.length,
      (index) => DataCell(
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return add_task();
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tugas: ${taskList[index].tugas ?? ""}"),
                Text("Catatan: ${taskList[index].catatan ?? ""}"),
                Text("Start: ${taskList[index].start ?? ""}"),
                Text("Deadline: ${taskList[index].deadline ?? ""}"),
                Text("Status: ${taskList[index].status ?? ""}"),
                Text("Nilai: ${taskList[index].nilai.toString()}"),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
