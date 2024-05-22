import 'package:drawer/constants/constants.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          BlocProvider(
              create: (context) => ProyekBloc(proyekServices: ProyekServices())
                ..add(LoadRecentProyek()),
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
                            label: Text("Deadline"),
                          ),
                          DataColumn(
                            label: Text("Nilai"),
                          ),
                        ],
                        rows: List.generate(
                          proyeks.length,
                          (index) =>
                              recentFileDataRow(proyeks[index], index + 1),
                        ),
                      ),
                    );
                  }

                  return SizedBox();
                },
              )),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(Proyek proyek, int id) {
  return DataRow(
    cells: [
      DataCell(Container(
        width: 50,
        child: Text(id.toString()),
      )),
      DataCell(Container(
        width: 300,
        child: Text(proyek.nama!),
      )),
      DataCell(Container(
        width: 200,
        child: Text(DateFormat('EEEE, MMMM d, y')
            .format(DateTime.parse(proyek.finish!))),
      )),
      DataCell(Container(
        width: 200,
        child: Text("${proyek.nilai}%"),
      )),
    ],
  );
}
