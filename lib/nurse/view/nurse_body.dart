import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/app_utils.dart';
import 'package:flutter_tv/config/color_constants.dart';
import 'package:formz/formz.dart';
import 'package:marquee/marquee.dart';

import '../../config/constants.dart';
import '../bloc/nurse_bloc.dart';
import '../bloc/nurse_event.dart';
import '../bloc/nurse_state.dart';

class NurseBody extends StatelessWidget {
  NurseBody({super.key});

  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NurseBloc, NurseState>(
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
      if (state.data.isNotEmpty && state.status == FormzStatus.pure) {
        Timer(const Duration(seconds: 6), () {
          BlocProvider.of<NurseBloc>(context).add(const NurseFetchEvent());
        });
        return;
      }
      if (state.isPlay) {
        // audioPlayer.play(UrlSource(Constants.soundUrl));
        print('audioPlayStart');
        await audioPlayer.play(UrlSource(Constants.soundUrl));
        print('audioPlayStart');
        return;
      }
    }, builder: (context, state) {
      // if (state.status.isSubmissionInProgress) {
      //   return const CircularProgressIndicator(
      //     color: ColorConstants.appRed,
      //   );
      // }
      // audioPlayer.play(UrlSource(Constants.soundUrl));
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
                      color: ColorConstants.titleHeaderYellow,
                      child: Row(children:  const [
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text('Counter No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: ColorConstants.greyishBrown2))),
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text('Calling Token',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstants.greyishBrown2)),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ]),
                    ),
                    Expanded(
                        child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 40,
                          child: Row(children: [
                            const Expanded(
                              flex: 3,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text('Counter $index',
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
                              child: Text('Token $index',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: ColorConstants.brownishGrey2)),
                            ),
                            const Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                          ]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ))
                  ],
                )),
          ),
          Container(child: _buildFooter())
          // _buildFooter()
        ],
      );
    });
  }

  _buildHeader(NurseState state) {
    return Row(
      children: [
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/images/ic_sps_logo.png',
              height: 40, fit: BoxFit.cover),
        )),
        const Spacer(),
        const Text("Nurse One",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: ColorConstants.brownishGrey)),
        const Spacer(),
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
              color: ColorConstants.slateTwo,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
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
                  child: Image.asset('assets/images/ic_app_logo.png',
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
