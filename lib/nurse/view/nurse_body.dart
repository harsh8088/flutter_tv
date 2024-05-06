import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/app_utils.dart';
import 'package:flutter_tv/config/color_constants.dart';
import 'package:flutter_tv/nurse/model/nurse_response.dart';
import 'package:flutter_tv/nurse/view/nurse_item.dart';
import 'package:formz/formz.dart';
import 'package:marquee/marquee.dart';

import '../bloc/nurse_bloc.dart';
import '../bloc/nurse_event.dart';
import '../bloc/nurse_state.dart';

class NurseBody extends StatelessWidget {
  const NurseBody({super.key});

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
      if (state.data?.deviceType == 2) {
        //DoctorTokens
        return;
      }
      if (state.data?.deviceType == 40) {
        //NurseTokens
        return;
      }
      if (state.data?.deviceType == 4 && state.status == FormzStatus.pure) {
        print("fetchData");
        Timer(const Duration(seconds: 8), () {
          BlocProvider.of<NurseBloc>(context).add(const NurseFetchEvent());
        });
        return;
      }
    }, builder: (context, state) {
      // if (state.status.isSubmissionInProgress) {
      //   return const CircularProgressIndicator(
      //     color: ColorConstants.appRed,
      //   );
      // }

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
                      child: const Row(children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text('Token',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: Colors.white))),
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text('Status',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.white)),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ]),
                    ),
                    const NurseItem(),
                    // Expanded(
                    //     child: ListView.separated(
                    //   padding: const EdgeInsets.all(0),
                    //   itemCount: state.tokens.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     if (state.data!.tokens![index].calledFlag == 1) {
                    //       return NurseBlinkToken(
                    //           tokens: state.data!.tokens![index]);
                    //     } else {
                    //       return SizedBox(
                    //         height: 40,
                    //         child: Row(children: [
                    //           const Expanded(
                    //             flex: 3,
                    //             child: SizedBox(),
                    //           ),
                    //           Expanded(
                    //             flex: 4,
                    //             child: Text(
                    //                 '${state.data!.tokens![index].token}',
                    //                 style: const TextStyle(
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 24,
                    //                     color: ColorConstants.brownishGrey2)),
                    //           ),
                    //           const Expanded(
                    //             flex: 3,
                    //             child: SizedBox(),
                    //           ),
                    //           Expanded(
                    //             flex: 4,
                    //             child: getStatus(state.data!.tokens![index]),
                    //           ),
                    //           const Expanded(
                    //             flex: 2,
                    //             child: SizedBox(),
                    //           ),
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

  Widget getStatus(Tokens tokens) {
    var status = tokens.calledFlag;
    if (status == 1) {
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
