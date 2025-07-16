import 'package:carousel_slider/carousel_slider.dart';

import 'package:earlyjobs/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomescreenCorouselslider extends StatelessWidget {
  HomescreenCorouselslider({super.key, required this.imageList});

  List imageList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          // print('$index ');
          return CachedNetworkImage(
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                image: const DecorationImage(
                    image: AssetImage('lib/Assets/placeholder.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            imageUrl: imageList[index],
            imageBuilder: (context, imageProvider) => Container(
              height: 150.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
              decoration: BoxDecoration(
                color: kgreycolor,
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 150.0.w,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class HomescreenCorouselsliderAssets extends StatelessWidget {
  HomescreenCorouselsliderAssets({super.key, required this.imageList});

  List imageList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          // print('$index ');
          return Container(
            height: 150.w,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            decoration: BoxDecoration(
              color: kwhitecolor,
              borderRadius: BorderRadius.circular(10.w),
              image: const DecorationImage(
                image: AssetImage('lib/Assets/Courousal_1_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          );

          // CachedNetworkImage(
          //   placeholder: (context, url) => Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5.w),
          //       image: const DecorationImage(
          //           image: AssetImage('lib/Assets/placeholder.jpg'),
          //           fit: BoxFit.cover),
          //     ),
          //   ),
          //   imageUrl: imageList[index],

          //   imageBuilder: (context, imageProvider) => Container(
          //     height: 150.w,
          //     width: double.infinity,
          //     margin: EdgeInsets.symmetric(horizontal: 5.0.w),
          //     decoration: BoxDecoration(
          //       color: kgreycolor,
          //       borderRadius: BorderRadius.circular(10.w),
          //       image: DecorationImage(
          //         image: imageProvider,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 150.0.w,
          autoPlay: false,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class HomescreenCorouselsliderLoding extends StatelessWidget {
  HomescreenCorouselsliderLoding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          // print('$index ');
          return Container(
            height: 150.w,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            decoration: BoxDecoration(
              color: kwhitecolor,
              borderRadius: BorderRadius.circular(10.w),
              image: const DecorationImage(
                image: AssetImage('lib/Assets/placeholder.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 150.0.w,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
