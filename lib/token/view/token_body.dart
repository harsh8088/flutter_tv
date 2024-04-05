import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/app_utils.dart';
import 'package:flutter_tv/config/color_constants.dart';
import 'package:flutter_tv/token/view/token_drop_down.dart';
import 'package:flutter_tv/token/view/token_item.dart';
import 'package:formz/formz.dart';
import 'package:marquee/marquee.dart';

import '../bloc/token_bloc.dart';
import '../bloc/token_event.dart';
import '../bloc/token_state.dart';

class TokenBody extends StatelessWidget {
  const TokenBody({super.key, required this.screen});

  final String screen;

  @override
  Widget build(BuildContext context) {
    print("width");
    print(MediaQuery.of(context).size.width);
    print("updatedWidth");
    print(MediaQuery.of(context).size.width * 0.33 * 2);
    var sWidth = MediaQuery.of(context).size.width;
    AudioPlayer audioPlayer = AudioPlayer();

    return BlocConsumer<TokenBloc, TokenState>(
        listener: (context, state) async {
      // if (state is SuccessState) {
      //   if (state.isPinAvailable)
      //     Navigator.pushNamed(context, "/login-pin").then((value) => _refreshState());
      //   else
      //     Navigator.pushNamed(context, "/otp");
      // }
      if (state.data.isNotEmpty && state.data[0].deviceType == 2) {
        //DoctorTokens
        return;
      }
      if (state.data.isNotEmpty && state.data[0].deviceType == 4) {
        //NurseTokens
        return;
      }
      if (state.isPlay) {
        // await audioPlayer.play(AssetSource('token_audio.mp3'),
        //     mode: PlayerMode.lowLatency);
        // audioPlayer.dispose();
        print("isPlayAudio");
      }
      if (state.data.isNotEmpty && state.status == FormzStatus.pure) {
        Timer(const Duration(seconds: 6), () {
          if (screen == 'token') {
            BlocProvider.of<TokenBloc>(context).add(const TokenFetchEvent());
          } else {
            BlocProvider.of<TokenBloc>(context)
                .add(const AllTokensFetchEvent());
          }
        });
        return;
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Container(
            child: _buildHeader(state),
          ),
          Expanded(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      color: ColorConstants.titleHeader,
                      child: Row(children: [
                        SizedBox(width: sWidth * 0.20),
                        SizedBox(
                          width: sWidth * .35,
                          child: const Text('Counter No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          width: sWidth * 0.05,
                        ),
                        SizedBox(
                          width: sWidth * .35,
                          child: const Text('Calling Token',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.white)),
                        ),
                        SizedBox(width: sWidth * 0.05),
                      ]),
                    ),
                    const TokenItem(),
                    const Divider()
                    // Expanded(
                    //     child: ListView.separated(
                    //   padding: const EdgeInsets.all(0),
                    //   itemCount: state.tokens.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     if (state.tokens[index].id == 5260 ||
                    //         state.tokens[index].id == 5264) {
                    //       return SizedBox(
                    //           height: 40,
                    //           child: BlinkToken(
                    //               index: index,
                    //               counter: '${state.tokens[index].counter}',
                    //               token: '${state.tokens[index].token}'));
                    //     } else {
                    //       return SizedBox(
                    //         height: 40,
                    //         child: Row(children: [
                    //           SizedBox(width: sWidth * 0.20),
                    //           SizedBox(
                    //             width: sWidth * .35,
                    //             child: Text('${state.tokens[index].counter}',
                    //                 style: const TextStyle(
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 24,
                    //                     color: ColorConstants.brownishGrey2)),
                    //           ),
                    //           SizedBox(width: sWidth * 0.05),
                    //           SizedBox(
                    //               width: sWidth * .35,
                    //               child: Text('${state.tokens[index].token}',
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.w500,
                    //                       fontSize: 24,
                    //                       color:
                    //                           ColorConstants.brownishGrey2))),
                    //           SizedBox(width: sWidth * 0.05),
                    //         ]),
                    //       );
                    //     }
                    //   },
                    //   separatorBuilder: (BuildContext context, int index) =>
                    //       const Divider(),
                    // ))
                  ],
                )),
          ),
          Container(child: _buildFooter())
          // _buildFooter()
        ],
      );
    });
  }

  _buildHeader(TokenState state) {
    return Row(
      children: [
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/images/ic_sps_logo.png',
              height: 40, fit: BoxFit.cover),
        )),
        const Spacer(),
        const Text("Floor One",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: ColorConstants.brownishGrey)),
        const Spacer(),
        // const DropDownWidget(data: Constants.tokenType, screen: "token"),
        const TokenDropDown(),
        const SizedBox(
          width: 10,
        ),
        Text('${AppUtils.getCurrentTime()}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorConstants.brownishGrey)),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  _buildFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          color: ColorConstants.bottomHeader,
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text("No-Show Tokens",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Colors.white)),
          ),
        ),
        Expanded(
          child: Container(
              height: 60,
              color: ColorConstants.titleHeader,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 2.0),
                child: Marquee(
                  text:
                      'For a missed token number, please inform at billing counter and wait, you will be called shortly.',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 200.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )),
        ),
        Container(
          color: ColorConstants.bottomMhcColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Text('Powered By',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 11,
                        color: ColorConstants.brownishGrey)),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset('assets/images/ic_mhc_logo.png',
                      height: 40, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class BlinkToken extends StatefulWidget {
//   const BlinkToken(
//       {required this.index,
//       required this.counter,
//       required this.token,
//       Key? key})
//       : super(key: key);
//
//   final int index;
//   final String counter;
//   final String token;
//
//   @override
//   State<BlinkToken> createState() => _BlinkTokenState();
// }
//
// class _BlinkTokenState extends State<BlinkToken>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController animationController;
//   Timer? timer;
//   AudioPlayer audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//
//   Future<void> startAnimation() async {
//     // after the scroll animation finishes, start the blinking
//     animationController.repeat(reverse: true);
//     // the duration of the blinking
//     timer = Timer(const Duration(seconds: 3), () {
//       setState(() {
//         animationController.stop();
//         timer?.cancel();
//       });
//     });
//
//     await audioPlayer.play(AssetSource('token_audio.mp3'),
//         mode: PlayerMode.lowLatency);
//   }
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     WidgetsBinding.instance!.addPostFrameCallback((_) => startAnimation());
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     animationController.dispose();
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var sWidth = MediaQuery.of(context).size.width;
//     return FittedBox(
//         child: FadeTransition(
//       opacity: Tween<double>(
//         begin: 0.3,
//         end: 1.0,
//       ).animate(animationController),
//       child: Row(children: [
//         SizedBox(width: sWidth * 0.20),
//         SizedBox(
//           width: sWidth * .35,
//           child: Text(widget.counter,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 24,
//                   color: ColorConstants.brownishGrey2)),
//         ),
//         SizedBox(width: sWidth * 0.05),
//         SizedBox(
//             width: sWidth * .35,
//             child: Text(widget.token,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 24,
//                     color: ColorConstants.brownishGrey2))),
//         SizedBox(width: sWidth * 0.05),
//       ]),
//     ));
//   }
// }
