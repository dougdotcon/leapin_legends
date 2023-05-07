import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TextCarousel extends StatefulWidget {
  const TextCarousel({
    Key? key,
  }) : super(key: key);
  @override
  State<TextCarousel> createState() => _TextCarouselState();
}

class _TextCarouselState extends State<TextCarousel> {
  int actualSlide = 0;
  List<Map<String, Object>> appDescription = [
    {'id': 0, 'text': 'Memory Game is a classic game of memory that challenges players to uncover matching pairs.'},
    {'id': 1, 'text': 'Players must use their memory skills to flip over tiles and uncover pairs of matching tiles.'},
    {'id': 2, 'text': 'Quickly uncover all of the tiles and check your rank in the leaderboard.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: 80.w),
          child: Text(
            'Leapin\nLegends',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
        Gap(30.h),
        Row(
          children: [
            for (var i in appDescription)
              Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    height: 7.h,
                    width: 7.w,
                    decoration: BoxDecoration(
                      color: actualSlide == i['id'] as int ? Colors.white : Colors.white24,
                      borderRadius: BorderRadius.circular(17),
                    ),
                  )),
          ],
        ),
        Gap(20.h),
        CarouselSlider(
          items: appDescription.map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        i['text'].toString(),
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  );
                },
              );
            },
          ).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                actualSlide = index;
              });
            },
            aspectRatio: 5,
            viewportFraction: 1,
            initialPage: 0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
          ),
        ),
      ],
    );
  }
}
