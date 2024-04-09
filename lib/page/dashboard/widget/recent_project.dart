import 'package:drawer/constants/constants.dart';
import 'package:drawer/models/data.dart';
import 'package:flutter/material.dart';

class RecentProject extends StatelessWidget {
  const RecentProject({
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
          Text(
            "Recent Project",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(label: Text("# Id")),
                DataColumn(label: Text("Project Name")),
                DataColumn(label: Text("Deadline")),
                DataColumn(label: Text("Status")),
              ],
              // Rows
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(Container(
        width: 50,
        child: Text(fileInfo.id!),
      )),
      DataCell(Container(
        width: 300,
        child: Text(fileInfo.title!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(fileInfo.deadline!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(fileInfo.status!),
      )),
    ],
  );
}
