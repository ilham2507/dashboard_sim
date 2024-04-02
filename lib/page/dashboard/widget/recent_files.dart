import 'package:drawer/constants/constants.dart';
import 'package:drawer/models/data.dart';
import 'package:flutter/material.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
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
          Text(
            "Recent Project",
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
                  label: Text("Deadline"),
                ),
                DataColumn(
                  label: Text("Status"),
                ),
              ],
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
      // DataCell(
      //   Row(
      //     children: [
      //       Text(fileInfo.id!),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      //         child: Text(fileInfo.title!),
      //       ),
      //     ],
      //   ),
      // ),
      DataCell(Text(fileInfo.id!)),
      DataCell(Text(fileInfo.title!)),
      DataCell(Text(fileInfo.deadline!)),
      DataCell(Text(fileInfo.status!)),
    ],
  );
}
