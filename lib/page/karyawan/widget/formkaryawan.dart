import 'package:flutter/material.dart';

class customform extends StatelessWidget {
  final String title;
  final bool obscuretext;
  final TextEditingController? controller;
  final bool isShowtitle;
  final TextInputType? keyboardType;

  const customform(
      {Key? key,
      required this.title,
      this.obscuretext = false,
      this.controller,
      this.isShowtitle = true,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowtitle)
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (isShowtitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscuretext,
          controller: controller,
          decoration: InputDecoration(
            hintText: !isShowtitle ? title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
