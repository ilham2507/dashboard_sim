import 'package:drawer/constants/constants.dart';
import 'package:drawer/constants/responsive.dart';
import 'package:drawer/data/services/proyek/proyek_bloc.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cardView extends StatelessWidget {
  const cardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          ProyekBloc(proyekServices: ProyekServices())..add(GetProyekCounts()),
      child: Container(
        child: Responsive(
          mobile: AnalyticInfoCardGridView(
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 ? 2 : 1.5,
          ),
          tablet: AnalyticInfoCardGridView(
            childAspectRatio: size.width < 1000 ? 2 : 4,
          ),
          desktop: AnalyticInfoCardGridView(
            childAspectRatio: size.width < 1400 ? 2 : 4,
          ),
        ),
      ),
    );
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProyekBloc, ProyekState>(
      builder: (context, state) {
        if (state is ProyekCountsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProyekCountsLoaded) {
          List<cardInfo> analyticData = [
            cardInfo(
              title: "On Progress",
              count: state.onProgress,
              image: "assets/icons/progres.png",
            ),
            cardInfo(
              title: "Selesai",
              count: state.totalProyekSelesai,
              image: "assets/icons/finish.png",
            ),
          ];

          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: analyticData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) => cardinfo(
              info: analyticData[index],
            ),
          );
        } else if (state is ProyekError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
    );
  }
}

class cardinfo extends StatelessWidget {
  const cardinfo({Key? key, required this.info}) : super(key: key);

  final cardInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${info.count}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    info.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(16 / 2),
                height: MediaQuery.of(context).size.width < 1400 ? 50 : 70,
                width: MediaQuery.of(context).size.width < 1400 ? 50 : 70,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  info.image!,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class cardInfo {
  final String? image, title;
  final int? count;

  cardInfo({
    this.image,
    this.title,
    this.count,
  });
}

// data masuk sini
List analyticData = [
  cardInfo(
    title: "Pekerjaan",
    count: 8,
    image: "assets/icons/progres.png",
  ),
  cardInfo(
    title: "selesai",
    count: 3,
    image: "assets/icons/finish.png",
  ),
];
