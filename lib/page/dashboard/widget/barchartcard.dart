import 'package:drawer/constants/constants.dart';
import 'package:drawer/page/dashboard/widget/barchart.dart';
import 'package:flutter/material.dart';

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
            "progress",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: barchart(),
          )
        ],
      ),
    );
  }
}
