import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
              titleWidget: Column(),
              bodyWidget: Column(
                children: [
                  Text(
                    'Discover our revolutionary IoT solution',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              image: Container(
                height: 900,
                margin: EdgeInsets.only(top: 100.0),
                child: Image.asset('assets/image/aa.png'),
              ),
            ),
            PageViewModel(
              titleWidget: Column(),
              bodyWidget: Column(
                children: [
                  Text(
                    'Our solution secures vital infrastructure\n providing advanced protection and real-time monitoring',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              image: Container(
                height: 900,
                margin: EdgeInsets.only(top: 100.0),
                child: Image.asset('assets/image/111.png'),
              ),
            ),
          ],
          showSkipButton: true,
          skip: const Icon(Icons.skip_next),
          next: const Icon(Icons.next_plan),
          done: const Text(
            "Done",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          onDone: () {
            Navigator.pushNamed(context, 'dashboard');
          },
          onSkip: () {
            Navigator.pushNamed(context, 'dashboard');
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Theme.of(context).colorScheme.secondary,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
