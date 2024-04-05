import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../config/color_constants.dart';

class BlinkToken extends StatefulWidget {
  const BlinkToken(
      {required this.index,
      required this.counter,
      required this.token,
      Key? key})
      : super(key: key);

  final int index;
  final String counter;
  final String token;

  @override
  State<BlinkToken> createState() => _BlinkTokenState();
}

class _BlinkTokenState extends State<BlinkToken>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
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
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) => startAnimation());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    animationController.dispose();
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    return FittedBox(
        child: FadeTransition(
      opacity: Tween<double>(
        begin: 0.3,
        end: 1.0,
      ).animate(animationController),
      child: Container(
        color: Colors.black12,
        child: Row(children: [
          SizedBox(width: sWidth * 0.20),
          SizedBox(
            width: sWidth * .35,
            child: Text(widget.counter,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: ColorConstants.brownishGrey2)),
          ),
          SizedBox(width: sWidth * 0.05),
          SizedBox(
              width: sWidth * .35,
              child: Text(widget.token,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: ColorConstants.brownishGrey2))),
          SizedBox(width: sWidth * 0.05),
        ]),
      ),
    ));
  }
}
