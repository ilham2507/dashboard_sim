import 'package:drawer/constants/constants.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/page/proyek/proyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class teamInfo extends StatelessWidget {
  teamInfo({Key? key, required this.svgSrc, this.proyek}) : super(key: key);

  final String svgSrc;
  Proyek? proyek;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(svgSrc),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proyek!.manager!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "manager",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
              size: 18,
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
