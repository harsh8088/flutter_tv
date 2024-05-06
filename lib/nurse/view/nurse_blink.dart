import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tv/nurse/model/nurse_response.dart';

import '../../config/color_constants.dart';

class NurseBlinkToken extends StatefulWidget {
  const NurseBlinkToken({required this.tokens, Key? key}) : super(key: key);

  final Tokens tokens;

  @override
  State<NurseBlinkToken> createState() => _NurseBlinkTokenState();
}

class _NurseBlinkTokenState extends State<NurseBlinkToken>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  Timer? timer;

  // AudioPlayer audioPlayer = AudioPlayer();
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

      // if (audioPlayer.state != PlayerState.playing) {
      //   await audioPlayer.play(AssetSource('token_audio.mp3'),
      //       mode: PlayerMode.lowLatency);
      // }
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
  void didUpdateWidget(covariant NurseBlinkToken oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) => startAnimation());
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
    print("DoctorBlink");
    var sWidth = MediaQuery.of(context).size.width;
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0.3,
          end: 1.0,
        ).animate(animationController),
        child: SizedBox(
          height: 40,
          child: Row(children: [
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: Text('${widget.tokens.token}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: ColorConstants.brownishGrey2)),
            ),
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: getStatus(widget.tokens!),
            ),
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
          ]),
        ));
  }

  Widget getStatus(Tokens tokens) {
    var status = tokens.calledFlag!;
    if (status == 1) {
      //Nurse Assessment
      return Text('${tokens.called}',
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstants.bottomHeader));
    } else if (status == 0) {
      return const Text('In Queue',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstants.brownishGrey2));
    } else {
      return const Text('',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstants.brownishGrey2));
    }
  }
}
