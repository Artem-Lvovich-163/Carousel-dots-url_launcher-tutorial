// ignore_for_file: sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          //primarySwatch: Color.fromARGB(100, 2, 125, 253),
          ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  final List<String> imgList = [
    'assets/images/vk.png',
    'assets/images/inst.png',
    'assets/images/utube.png',
  ];

  final List<String> urlList = [
    'https://vk.com/artemlvovich1',
    'https://www.instagram.com/artembulankin?r=nametag',
    'https://www.youtube.com/channel/UCsO-IY8JFyEC8dlJoHnx1NA',
  ];

  Future<void> openInBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(2, 125, 243, 1),
        title: const Text('CAROUSEL TUTORIAL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    height: 200),
                itemCount: imgList.length,
                itemBuilder: (context, index, realIndex) {
                  return MyTile(
                    image: imgList[index],
                    press: () => openInBrowser(urlList[index]),
                  );
                }),
            const SizedBox(height: 5),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgList.length,
        effect: const JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 15,
          dotWidth: 15,
          activeDotColor: Color.fromRGBO(
            2,
            125,
            243,
            1,
          ),
        ),
      );
}

class MyTile extends StatelessWidget {
  const MyTile({super.key, required this.image, required this.press});

  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: InkWell(
        onTap: press,
        child: Image.asset(image),
      ),
    );
  }
}
