import 'package:drawer/constants/constants.dart';
import 'package:drawer/page/proyek/widget/widget%20add%20proyek/formproyek.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class add_task extends StatefulWidget {
  const add_task({super.key});

  @override
  State<add_task> createState() => _add_taskState();
}

class _add_taskState extends State<add_task> {
  final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Tambah Tugas"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customformProyek(title: "Tugas"),
            customformProyek(title: "Catatan"),
            Column(
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
                MultiSelectDropDown(
                  borderColor: Colors.white,
                  fieldBackgroundColor: secondaryColor,
                  dropdownBackgroundColor: secondaryColor,
                  optionsBackgroundColor: secondaryColor,
                  controller: _controller,
                  onOptionSelected: (options) {
                    debugPrint(options.toString());
                  },
                  options: const <ValueItem>[
                    ValueItem(label: 'Option 1', value: '1'),
                    ValueItem(label: 'Option 2', value: '2'),
                    ValueItem(label: 'Option 3', value: '3'),
                    ValueItem(label: 'Option 4', value: '4'),
                    ValueItem(label: 'Option 5', value: '5'),
                    ValueItem(label: 'Option 6', value: '6'),
                  ],
                  // maxItems: 2,
                  disabledOptions: const [
                    ValueItem(label: 'Option 1', value: '1')
                  ],
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            customformProyek(title: "start"),
            customformProyek(title: "Deadline"),
            customformProyek(title: "Status"),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text("submit"),
          onPressed: () {
            // your code
          },
        ),
      ],
    );
  }
}
