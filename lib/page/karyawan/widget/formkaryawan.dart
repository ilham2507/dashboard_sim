import 'package:flutter/material.dart';

class customform extends StatefulWidget {
  final String title;
  final bool obscuretext;
  final TextEditingController? controller;
  final bool isReadOnly;
  final bool isShowtitle;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;

  const customform(
      {Key? key,
      required this.title,
      this.obscuretext = false,
      this.controller,
      this.isReadOnly = false,
      this.isShowtitle = true,
      this.onTap,
      this.keyboardType})
      : super(key: key);

  @override
  State<customform> createState() => _customformState();
}

class _customformState extends State<customform> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowtitle)
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (widget.isShowtitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscuretext,
          controller: widget.controller,
          readOnly: widget.isReadOnly,
          decoration: InputDecoration(
            hintText: !widget.isShowtitle ? widget.title : null,
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
