import 'package:drawer/constants/constants.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/page/dashboard/widget/team_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class team extends StatelessWidget {
  const team({
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
      child: BlocProvider(
          create: (context) =>
              ProyekBloc(proyekServices: ProyekServices())..add(LoadProyek()),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project leaders",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: proyeks.length,
                      itemBuilder: (context, index) {
                        return teamInfo(
                          svgSrc: "assets/icons/media.svg",
                          proyek: proyeks[index],
                        );
                      },
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          )),
    );
  }
}
