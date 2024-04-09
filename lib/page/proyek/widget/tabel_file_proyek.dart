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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              child: DataTable(
                columnSpacing: defaultPadding,
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
          ),
        ],
      ),
    );
  }
}

DataRow proyekFileDataRow(proyekfiledata fileInfo) {
  return DataRow(
    cells: [
      DataCell(Container(
        width: 50,
        child: Text(fileInfo.id!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(fileInfo.title!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(fileInfo.klien!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(fileInfo.manager!),
      )),
      DataCell(Container(
        width: 100,
        child: Text(fileInfo.start!),
      )),
      DataCell(Container(
        width: 100,
        child: Text(fileInfo.deadline!),
      )),
      DataCell(Container(
        width: 100,
        child: Text(fileInfo.finish!),
      )),
      DataCell(Container(
        width: 100,
        child: Text(fileInfo.status!),
      )),
    ],
  );
}
