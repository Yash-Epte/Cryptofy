import 'package:crytojay/widgets/home/background_curves_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        // Positioned(
        //   left: -300,
        //   top: -00,
        //   child: Container(
        //     height: 500,
        //     width: 600,
        //     decoration: BoxDecoration(
        //       gradient: RadialGradient(
        //         colors: [
        //           Theme.of(context).colorScheme.primary.withOpacity(0.3),
        //           Theme.of(context).colorScheme.background.withOpacity(0.5),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // CustomPaint(
        //   painter: BackgroundCurvesPainter(),
        //   size: Size.infinite,
        // ),
        Container(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //     height: 280,
                //     width: 280,
                //     child: Lottie.asset("assets/animations/loading.json")),
                SpinKitWaveSpinner(
                  color: Colors.white,
                  waveColor: Colors.white,
                  size: 100.0,
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Getting the predictions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    )));
  }
}
