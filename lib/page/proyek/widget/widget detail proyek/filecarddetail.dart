import 'package:drawer/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class fileCardDetailProyek extends StatelessWidget {
  const fileCardDetailProyek({
    Key? key,
    required this.svgSrc,
    required this.jabatan,
  }) : super(key: key);

  final String svgSrc, jabatan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: SvgPicture.asset(svgSrc),
          ),
          SizedBox(width: defaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Foto Profil",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                jabatan,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
