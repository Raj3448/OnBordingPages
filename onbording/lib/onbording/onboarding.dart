import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zapx/zapx.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late final PageController _controller;

  final List _colorList = [
    const Color(0xFFFF0055),
    const Color(0xFF008CFF),
    const Color(0xFF6004FF)
  ];
  final List backGroundColr = [
    const Color(0xFFF0B3DA),
    const Color(0xFFBCE2FB),
    const Color(0xFFD9C6F3)
  ];
  double percentage = 0.34;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColr[currentIndex],
      appBar: AppBar(
        backgroundColor: backGroundColr[currentIndex],
        actions: [
          TextButton(
                  style: ButtonStyle(
                    fixedSize: const MaterialStatePropertyAll(Size(80, 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2, color: _colorList[currentIndex]),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  onPressed: () {
                    setState(() {
                      percentage += 0.33;
                    });
                    _controller.jumpToPage(2);
                  },
                  child: Text('Skip',
                      style: TextStyle(
                          color: _colorList[currentIndex], fontSize: 18)))
              .paddingOnly(right: 10)
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 3,
            controller: _controller,
            onPageChanged: (index) {
              if (index >= currentIndex) {
                setState(() {
                  percentage += 0.33;
                  currentIndex = index;
                });
              } else {
                setState(() {
                  percentage -= 0.33;
                  currentIndex = index;
                });
              }
              _controller.nextPage(
                  duration: const Duration(seconds: 1), curve: Curves.easeIn);
              _controller.jumpToPage(index);
            },
            itemBuilder: (context, index) => LottieBuilder.asset(
              'assets/animations/${index + 1}.json',
              width: 150,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  axisDirection: Axis.horizontal,
                ),
                const SizedBox(
                  height: 30,
                ),
                currentIndex == 2
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                _colorList[currentIndex]),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(150, 40))),
                        onPressed: () {},
                        child: const Text('Get Start',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)))
                    : Stack(
                        alignment: const Alignment(0, 0),
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: CircularProgressIndicator(
                              value: percentage,
                              backgroundColor:
                                  const Color.fromARGB(82, 255, 255, 255),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _colorList[currentIndex],
                              ),
                              //color: _colorList[currentIndex],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (currentIndex == _colorList.length - 1) {
                                // Go to next page...
                              }

                              _controller.nextPage(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeIn,
                              );
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: _colorList[currentIndex],
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
