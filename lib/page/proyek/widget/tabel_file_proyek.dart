import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/models/data.dart';
import 'package:drawer/page/proyek/widget/topjudulproyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

DataRow proyekFileDataRow(BuildContext context, Proyek proyek, int id) {
  return DataRow(
    onLongPress: () {
      context.read<MenuAppController>().setSelectedItem('add proyek',
          id: proyek.id.toString(), isUpdate: true);
    },
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
            width: 100,
            child: Text(proyek.start!),
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
            child: Text(proyek.finish!),
          ),
        ),
      ),
    ],
  );
}
