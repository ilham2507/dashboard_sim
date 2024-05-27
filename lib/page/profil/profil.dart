import 'package:drawer/constants/constants.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/data/services/users/users_bloc.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:drawer/page/sidebar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class profil extends StatelessWidget {
  const profil({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

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
                            children: [
                              Container(width: 400, child: imageProfile()),
                              detailProfile(),
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            // constraints: BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                imageProfile(),
                                SizedBox(
                                  width: 20,
                                ),
                                Center(child: detailProfile()),
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
  const imageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(180),
              ),
              color: bgColor),
          child: Image.asset(
            "assets/photos/user.png",
            width: isSmallScreen ? 100 : 200,
            height: isSmallScreen ? 100 : 200,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // ElevatedButton.icon(
        //   icon: const Icon(Icons.edit),
        //   label: const Text("Edit"),
        //   onPressed: () {
        //     context.read<MenuAppController>().setSelectedItem('add karyawan');
        //   },
        // ),
      ],
    );
  }
}

class detailProfile extends StatelessWidget {
  const detailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UsersBloc(userService: UserService())..add(GetUserData()),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserDataLoaded) {
            final user = state.user;
            return Container(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.name!),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NIP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.nip!),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jabatan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.role!.name),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.email!),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.username!),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.jenisKelamin!),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal Lahir",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(DateFormat('dddd MMMM yyyy')
                            .format(user.tanggalLahir!)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. Telepone",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.noTelp!),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(user.alamat!),
                      ],
                    ),
                  ),
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
      ),
    );
  }
}
