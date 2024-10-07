import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/Login_Screen.dart';

class BoardingModle {
  late final String image;
  late final String title;
  late final String body;
  BoardingModle({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();

  List<BoardingModle> boarding = [
    BoardingModle(
      title: 'On Boarding 1 title',
      image: 'assets/images/Road trip-rafiki 1.png',
      body: 'On Boarding 1 body',
    ),
    BoardingModle(
      title: 'On Boarding 2 title',
      image: 'assets/images/Road trip-amico 1.png',
      body: 'On Boarding 2 body',
    ),
    BoardingModle(
      title: 'On Boarding 3 title',
      image: 'assets/images/Relaxation-cuate 1.png',
      body: 'On Boarding 3 body',
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true)?.then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ZoomLoginScreen(),
        );
      }
    });
    navigateAndFinish(
      context,
      ZoomLoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        actions: [
          defaultTextButton(
            function: submit,
            text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.brown,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Color(0xFF81D4FA),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    }
                    boardcontroller.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModle modle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${modle.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${modle.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${modle.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
