import 'package:drawer/constants/constants.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/page/dashboard/widget/barchart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class barchartcard extends StatelessWidget {
  const barchartcard({super.key});

  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
            "Progress",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: BlocProvider(
            create: (context) => ProyekBloc(proyekServices: ProyekServices())
              ..add(GetProjectData()),
            child: BlocBuilder<ProyekBloc, ProyekState>(
              builder: (context, state) {
                if (state is ProjectDataLoading) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is ProjectDataLoaded) {
                  return BarChartWidget(projects: state.projects);
                } else if (state is ProyekError) {
                  return Center(child: Text('Error: ${state.error}'));
                } else {
                  return Container();
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}
