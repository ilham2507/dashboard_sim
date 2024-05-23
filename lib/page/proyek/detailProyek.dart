import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/data/model/task_proyek.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:drawer/page/proyek/widget/widget%20detail%20proyek/filecarddetail.dart';
import 'package:drawer/page/proyek/widget/widget%20detail%20proyek/tabel_task_proyek.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class detailProyek extends StatelessWidget {
  String? id;
  detailProyek({this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        BlocProvider(
                            create: (context) =>
                                ProyekBloc(proyekServices: ProyekServices())
                                  ..add(GetProyekById(userId: id ?? "")),
                            child: BlocBuilder<ProyekBloc, ProyekState>(
                              builder: (context, state) {
                                if (state is ProyekLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is ProyekByIdLoaded) {
                                  final proyek = state.proyek;
                                  return Container(
                                    padding: EdgeInsets.all(defaultPadding),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          proyek.nama ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          proyek.detail ?? "",
                                          textAlign: TextAlign.justify,
                                        ),
                                        Wrap(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: defaultPadding,
                                                  top: defaultPadding,
                                                  bottom: defaultPadding),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Start :",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // Text(proyek.start.toString()),
                                                  Text(DateFormat(
                                                          'EEEE, MMMM d, y')
                                                      .format(DateTime.parse(
                                                          proyek.start!)))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: defaultPadding,
                                                  top: defaultPadding,
                                                  bottom: defaultPadding),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Finish :",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(DateFormat(
                                                          'EEEE, MMMM d, y')
                                                      .format(DateTime.parse(
                                                          proyek.finish!)))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: defaultPadding,
                                                  top: defaultPadding,
                                                  bottom: defaultPadding),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Klien :",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(proyek.klien ?? ""),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Wrap(
                                        //   children: [
                                        //     Text(
                                        //       "Team : ",
                                        //       style: TextStyle(
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //     ),
                                        //     Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: proyek.taskProyek !=
                                        //               null
                                        //           ? proyek.taskProyek!
                                        //               .map((task) {
                                        //               return Text(
                                        //                   task.user?.name ??
                                        //                       "Unknown");
                                        //             }).toList()
                                        //           : [Text("No team members")],
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  );
                                } else if (state is ProyekError) {
                                  return Center(
                                    child: Text(
                                        'Failed to load user: ${state.error}'),
                                  );
                                } else {
                                  return const Center(
                                    child: Text('Unknown state'),
                                  );
                                }
                              },
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(
                                20,
                              )),
                          child: tabelTaskProyek(
                            id: id,
                          ),
                        ),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) filedetailproyek(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: filedetailproyek(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class filedetailproyek extends StatelessWidget {
  const filedetailproyek({Key? key}) : super(key: key);

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
            "Files",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          fileCardDetailProyek(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          fileCardDetailProyek(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          SizedBox(height: defaultPadding),
          Center(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.save),
                label: Text("Simpan"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
