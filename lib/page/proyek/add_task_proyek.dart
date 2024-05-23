import 'package:drawer/constants/constants.dart';
import 'package:drawer/data/model/task_proyek.dart';
import 'package:drawer/data/services/proyek/task/task_bloc.dart';
import 'package:drawer/data/services/proyek/task/task_service.dart';
import 'package:drawer/data/services/users/user_services.dart';
import 'package:drawer/data/services/users/users_bloc.dart';
import 'package:drawer/page/karyawan/widget/formkaryawan.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/formproyek.dart';
import 'package:flutter/material.dart';
import 'package:drawer/controller/MenuAppController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class add_task extends StatefulWidget {
  String id;
  bool? isUpdate;
  String? idTask;
  TaskProyek? taskProyek;
  add_task(
      {required this.id,
      this.isUpdate,
      this.idTask,
      this.taskProyek,
      super.key});

  @override
  State<add_task> createState() => _add_taskState();
}

class _add_taskState extends State<add_task> {
  final MultiSelectController _controller = MultiSelectController();

  List selectedUserId = [];
  bool isLoading = false;

  final tugas = TextEditingController();
  final catatan = TextEditingController();
  final start = TextEditingController();
  final deadline = TextEditingController();
  final status = TextEditingController();
  final nilai = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tugas.text = widget.taskProyek!.tugas!;
    catatan.text = widget.taskProyek!.catatan!;
    start.text = widget.taskProyek!.start!;
    deadline.text = widget.taskProyek!.deadline!;
    status.text = widget.taskProyek!.status!;
    nilai.text = widget.taskProyek!.nilai!.toString();
  }

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String tglnew = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        start.text = tglnew;
      });
    }
  }

  void selectDate2(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String tglnew = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        deadline.text = tglnew;
      });
    }
  }

  void saveTask() async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> userData = {
        'tugas': tugas.text,
        'catatan': catatan.text,
        'start': start.text,
        'deadline': deadline.text,
        'status': status.text,
        'nilai': nilai.text,
        'user_ids': selectedUserId,
        'proyek_id': widget.idTask,
      };
      final taskServices = TaskService();
      if (widget.isUpdate == false) {
        await taskServices.storeTask(userData);
      } else {
        await taskServices.updateTaskById(widget.id, userData);
      }

      // Show success message
      Fluttertoast.showToast(
          msg: widget.isUpdate == true
              ? "Update task successfully"
              : "Store task successfully",
          toastLength: Toast.LENGTH_LONG);
      context.read<MenuAppController>().setSelectedItem('dashboard');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to save proyek: $e", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Tambah Tugas"),
      content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customformProyek(
                title: "Tugas",
                controller: tugas,
              ),
              customformProyek(
                title: "Catatan",
                controller: catatan,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocProvider(
                      create: (context) => UsersBloc(userService: UserService())
                        ..add(LoadUser()),
                      child: BlocBuilder<UsersBloc, UsersState>(
                        builder: (context, state) {
                          if (state is UsersLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is UsersLoaded) {
                            final List<
                                ValueItem<
                                    dynamic>> dropdownOptions = state.users
                                .map((user) => ValueItem(
                                    label:
                                        "Nama : ${user.name} - Role : ${user.role!.name}",
                                    value: user.id))
                                .toList();
                            return MultiSelectDropDown(
                              borderColor: Colors.white,
                              fieldBackgroundColor: bgColor,
                              dropdownBackgroundColor: secondaryColor,
                              optionsBackgroundColor: secondaryColor,
                              controller: _controller,
                              onOptionSelected: (options) {
                                setState(() {
                                  selectedUserId = options
                                      .map((option) => option.value)
                                      .toList();
                                });
                                debugPrint(selectedUserId.toString());
                                debugPrint(options.toString());
                              },
                              options: dropdownOptions,
                              disabledOptions: const [
                                ValueItem(label: 'Option 1', value: '1')
                              ],
                              selectionType: SelectionType.multi,
                              chipConfig:
                                  const ChipConfig(wrapType: WrapType.wrap),
                              optionTextStyle: const TextStyle(fontSize: 16),
                              selectedOptionIcon:
                                  const Icon(Icons.check_circle),
                            );
                          } else if (state is UsersError) {
                            return Center(child: Text('Error: ${state.error}'));
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              customform(
                title: "start",
                controller: start,
                onTap: () {
                  selectDate(context);
                },
              ),
              customform(
                title: "Deadline",
                controller: deadline,
                onTap: () {
                  selectDate2(context);
                },
              ),
              customformProyek(
                title: "Status",
                controller: status,
              ),
              customformProyek(
                title: "Nilai",
                controller: nilai,
              ),
            ],
          )),
      actions: [
        ElevatedButton(
          child: const Text("submit"),
          onPressed: () {
            saveTask();
          },
        ),
      ],
    );
  }
}
