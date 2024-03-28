import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/doctor/model/blink_token_data.dart';

class DoctorBlinkToken extends StatefulWidget {
  const DoctorBlinkToken({required this.tokenBlinkData, Key? key})
      : super(key: key);

  final TokenBlinkData tokenBlinkData;

  @override
  State<DoctorBlinkToken> createState() => _DoctorBlinkTokenState();
}

class _DoctorBlinkTokenState extends State<DoctorBlinkToken>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  Timer? timer;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<void> startAnimation() async {
    try {
      // after the scroll animation finishes, start the blinking
      animationController.repeat(reverse: true);
      // the duration of the blinking
      timer = Timer(const Duration(seconds: 3), () {
        setState(() {
          animationController.stop();
          timer?.cancel();
        });
      });

      await audioPlayer.play(AssetSource('token_audio.mp3'),
          mode: PlayerMode.lowLatency);
    } catch (_) {
      print(_.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => startAnimation());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DoctorBlinkToken oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) => startAnimation());
  }

  @override
  void dispose() {
    timer?.cancel();
    animationController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("DoctorBlink");
    var sWidth = MediaQuery.of(context).size.width;
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0.3,
          end: 1.0,
        ).animate(animationController),
        child: Text("${widget.tokenBlinkData.progressToken}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white))
        // Container(
        //   color: ColorConstants.slateTwo,
        //   child: ListView(
        //     children: [
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       const Text("In Progress",
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 24,
        //               color: ColorConstants.bottomHeader)),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Text("${widget.tokenBlinkData.progressToken}",
        //           textAlign: TextAlign.center,
        //           style: const TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 26,
        //               color: Colors.white)),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Text("${widget.tokenBlinkData.progressPatientName}",
        //                 textAlign: TextAlign.center,
        //                 style: const TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 23,
        //                     color: Colors.white)),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
