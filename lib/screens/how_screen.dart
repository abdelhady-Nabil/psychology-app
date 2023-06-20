import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../widget/constant.dart';
class HowScreen extends StatefulWidget {
  const HowScreen({Key? key}) : super(key: key);

  @override
  State<HowScreen> createState() => _HowScreenState();
}

class _HowScreenState extends State<HowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        title: Text('كيف تستخدم الابليكيشن'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ImageSlideshow(
          width: double.infinity,
          height: 90,
          initialPage: 0,
          indicatorColor: PrimaryColor,
          indicatorBackgroundColor: Colors.grey,
          children: [
            Image.asset(
              'images/h1.png',
              //fit: BoxFit.fill,
            ),
            Image.asset(
              'images/h2.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h3.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h4.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h5.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h6.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h7.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h8.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h9.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h10.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h12.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h11.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h13.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h14.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h15.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h16.png',
              //fit: BoxFit.cover,
            ),
            Image.asset(
              'images/h17.png',
              //fit: BoxFit.cover,
            ),
          ],
         // autoPlayInterval: 3000,
          //isLoop: true,
        ),
      ),
    );
  }
}
