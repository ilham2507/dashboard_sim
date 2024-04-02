import 'package:drawer/constants/constants.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/proyek/widget/topjudulproyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("# Id"),
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
                  label: Text("Deadline"),
                ),
                DataColumn(
                  label: Text("Finished"),
                ),
                DataColumn(
                  label: Text("Status"),
                ),
              ],
              rows: List.generate(
                demoproyekfile.length,
                (index) => proyekFileDataRow(demoproyekfile[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow proyekFileDataRow(proyekfiledata fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.id!)),
      DataCell(Text(fileInfo.title!)),
      DataCell(Text(fileInfo.klien!)),
      DataCell(Text(fileInfo.manager!)),
      DataCell(Text(fileInfo.start!)),
      DataCell(Text(fileInfo.deadline!)),
      DataCell(Text(fileInfo.finish!)),
      DataCell(Text(fileInfo.status!)),
    ],
  );
}
