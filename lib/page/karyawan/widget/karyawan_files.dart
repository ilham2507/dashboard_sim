import 'package:drawer/constants/constants.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/karyawan/widget/topjudul.dart';
import 'package:flutter/material.dart';

class karyawanfile extends StatelessWidget {
  const karyawanfile({
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
          topjudulkaryawan(),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // controller: ScrollController(),
              child: DataTable(
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("# Id"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Position"),
                  ),
                  DataColumn(
                    label: Text("Birth"),
                  ),
                  DataColumn(
                    label: Text("No. Telp"),
                  ),
                  DataColumn(
                    label: Text("Email"),
                  ),
                  DataColumn(
                    label: Text("Gender"),
                  ),
                  DataColumn(
                    label: Text("Address"),
                  ),
                ],
                rows: List.generate(
                  demokaryawanfile.length,
                  (index) => karyawanFileDataRow(demokaryawanfile[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow karyawanFileDataRow(karyawanfiledata fileInfo) {
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
        width: 100,
        child: Text(fileInfo.position!),
      )),
      DataCell(Container(
        width: 100,
        child: Text(fileInfo.birth!),
      )),
      DataCell(Container(
        width: 130,
        child: Text(fileInfo.telp!),
      )),
      DataCell(Container(
        width: 130,
        child: Text(fileInfo.email!),
      )),
      DataCell(Container(
        width: 100,
        child: Text(fileInfo.gender!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(fileInfo.address!),
      )),
      // DataCell(Text(fileInfo.id!)),
      // DataCell(Text(fileInfo.title!)),
      // DataCell(Text(fileInfo.position!)),
      // DataCell(Text(fileInfo.birth!)),
      // DataCell(Text(fileInfo.telp!)),
      // DataCell(Text(fileInfo.email!)),
      // DataCell(Text(fileInfo.gender!)),
      // DataCell(Text(fileInfo.address!)),
    ],
  );
}
