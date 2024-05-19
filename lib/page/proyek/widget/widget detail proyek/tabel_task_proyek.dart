import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/proyek/add_task_proyek.dart';
import 'package:flutter/material.dart';

class tabelTaskProyek extends StatelessWidget {
  const tabelTaskProyek({
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              child: DataTable(
                columnSpacing: defaultPadding,
                columns: [
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
                ],
                // Rows
                rows: List.generate(
                  demoRecentTask.length,
                  (index) => recentTaskDataRow(context, demoRecentTask[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentTaskDataRow(BuildContext context, RecentTask fileInfo) {
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(fileInfo.tugas!),
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(fileInfo.catatan!),
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(fileInfo.pekerja!),
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(fileInfo.start!),
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(fileInfo.deadline!),
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(fileInfo.status!),
          ),
        ),
      ),
    ],
  );
}
