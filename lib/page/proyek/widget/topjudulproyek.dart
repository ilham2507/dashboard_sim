import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class topjudulproyek extends StatelessWidget {
  // Proyek? proyek;
  topjudulproyek({
    Key? key,
    // this.proyek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _getRoleId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final roleId = snapshot.data!;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Proyek",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (roleId != 4)
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        context.read<MenuAppController>().setSelectedItem(
                            'add proyek',
                            id: "",
                            isUpdate: false,
                            proyeks: Proyek(
                                id: 0,
                                userId: 0,
                                nama: "",
                                detail: "",
                                manager: "",
                                file: "",
                                start: "",
                                finish: "",
                                createdAt: "",
                                nilai: 0,
                                klien: "",
                                updatedAt: "",
                                taskProyek: []));
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
                    ),
                ],
              ),
              SizedBox(height: defaultPadding),
            ],
          );
        }
      },
    );
  }

  Future<int> _getRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role_id') ?? 0;
  }
}
