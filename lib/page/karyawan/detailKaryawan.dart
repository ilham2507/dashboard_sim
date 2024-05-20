import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/services/api/api_services.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/data/services/users/users_bloc.dart';
import 'package:drawer/page/profil/profil.dart';

import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class detailKaryawan extends StatelessWidget {
  String? idUser;
  detailKaryawan({this.idUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final Widget profileWidget = detailProfile(idUser ?? "");
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Container(
                padding: EdgeInsets.all(defaultPadding),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(
                      20,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isSmallScreen
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 400,
                                  child: imageProfile(
                                    id: idUser ?? "",
                                  )),
                              profileWidget
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                imageProfile(
                                  id: idUser ?? "",
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Center(child: profileWidget),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class imageProfile extends StatelessWidget {
  String id;
  imageProfile({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return BlocProvider(
        create: (context) =>
            UsersBloc(userService: UserService())..add(GetUserById(userId: id)),
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserByIdLoaded) {
              final user = state.user;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      color: bgColor,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "${ApiServices.imageUrl}${user.fotoProfile}",
                        width: isSmallScreen ? 100 : 200,
                        height: isSmallScreen ? 100 : 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                    onPressed: () {
                      context
                          .read<MenuAppController>()
                          .setSelectedItem('add karyawan');
                    },
                  ),
                ],
              );
            } else if (state is UsersError) {
              return Center(
                child: Text('Failed to load user: ${state.error}'),
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          },
        ));
  }
}

Container profileData(String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(subtitle),
      ],
    ),
  );
}

Widget detailProfile(String id) {
  return BlocProvider(
      create: (context) =>
          UsersBloc(userService: UserService())..add(GetUserById(userId: id)),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserByIdLoaded) {
            final user = state.user;
            return Container(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileData("Nama", user.name),
                  profileData("Nip", user.nip),
                  profileData("Email", user.email),
                  profileData("Username", user.username),
                  profileData("Jenis Kelamin", user.jenisKelamin),
                  profileData("Tanggal Lahir",
                      DateFormat('dddd MMMM yyyy').format(user.tanggalLahir)),
                  profileData("No. Telepon", user.noTelp),
                  profileData("Alamat", user.alamat),
                  profileData("Role", user.role.name),
                ],
              ),
            );
          } else if (state is UsersError) {
            return Center(
              child: Text('Failed to load user: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ));
}
