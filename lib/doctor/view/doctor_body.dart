import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/app_utils.dart';
import 'package:flutter_tv/config/color_constants.dart';
import 'package:flutter_tv/doctor/bloc/doctor_event.dart';
import 'package:flutter_tv/doctor/bloc/doctor_state.dart';
import 'package:flutter_tv/doctor/view/doctor_blink.dart';
import 'package:flutter_tv/doctor/view/doctor_drop_down.dart';
import 'package:marquee/marquee.dart';

import '../../networking/response.dart';
import '../bloc/doctor_bloc.dart';
import 'doctor_status.dart';

class DoctorBody extends StatelessWidget {
  const DoctorBody({super.key});

  @override
  Widget build(BuildContext context) {
    print("width");
    print(MediaQuery.of(context).size.width);
    print("updatedWidth");
    print(MediaQuery.of(context).size.width * 0.33 * 2);
    var sWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<DoctorBloc, DoctorState>(
        listener: (context, state) async {
      // if (state is SuccessState) {
      //   if (state.isPinAvailable)
      //     Navigator.pushNamed(context, "/login-pin").then((value) => _refreshState());
      //   else
      //     Navigator.pushNamed(context, "/otp");
      // }
      print('listenerCalled:${state.status}');
      if (state.data.isNotEmpty &&
          state.data[0].deviceType == 2 &&
          state.status == EventStatus.pure) {
        //DoctorTokens
        Future.delayed(const Duration(seconds: 6), () {
          if (context.mounted) {
            BlocProvider.of<DoctorBloc>(context).add(const DoctorFetchEvent());
          }
        });

        return;
      }
      if (state.data.isNotEmpty && state.data[0].deviceType == 4) {
        //NurseTokens
        return;
      }
    }, builder: (context, state) {
      var index = state.doctorIndex;
      if (state.status == EventStatus.pure) {
        return Column(
          children: [
            _buildHeader(state),
            Expanded(
              child: Row(
                children: [
                  _buildDoctor(state, index),
                  _buildTokens(state, sWidth, index)
                ],
              ),
            ),
            _buildFooter()
            // _buildFooter()
          ],
        );
      } else {
        return Container();
      }
    });
  }

  _buildHeader(DoctorState state) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/images/ic_sps_logo.png',
              height: 40, fit: BoxFit.cover),
        ),
        const Spacer(),
        const Expanded(
          child: Text("Doctor One",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: ColorConstants.brownishGrey)),
        ),
        const Spacer(),
        const DoctorDropDown(),
        const SizedBox(
          width: 10,
        ),
        Text('${AppUtils.getCurrentTime()}',
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
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

  _buildDoctor(DoctorState state, int dIndex) {
    print(
        "state.doctorIndex:${state.doctorIndex},${state.blinkToken},${state.tokenBlinkData!.blinkToken!}");
    var doctor = state.data2!.doctors![dIndex];
    return Expanded(
        flex: 2,
        child: Column(children: [
          Expanded(
            flex: 5,
            child: Container(
              // width: double.infinity,
              color: ColorConstants.battleshipGrey,
              child: state.data.isNotEmpty
                  ? ListView(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Image.asset('assets/images/ic_mhc_logo.png',
                                height: 70, fit: BoxFit.cover),
                            const SizedBox(height: 10),
                            Text(doctor.firstName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white)),
                            Text('${doctor.specialities?.join(', ')}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: Colors.white)),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                      '${AppUtils.getDoctorTimeDate(doctor.workingTime?.startTime)} - ${AppUtils.getDoctorTimeDate(doctor.workingTime?.endTime)}',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                          color: Colors.white)),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                DoctorStatusWidget(
                                    hospitalId: state.data2!.hospital!.id!,
                                    doctorId: doctor.id!),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(doctor.room!.name!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white)),
                          ],
                        )
                      ],
                    )
                  : const SizedBox(),
            ),
          ), //Top Widget
          Expanded(
            flex: 3,
            child: Container(
              color: ColorConstants.slateTwo,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("In Progress",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: ColorConstants.bottomHeader)),
                  const SizedBox(
                    height: 10,
                  ),
                  state.tokenBlinkData!.blinkToken!
                      ? DoctorBlinkToken(tokenBlinkData: state.tokenBlinkData!)
                      : Text("${state.tokenBlinkData?.progressToken}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.white)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "${state.tokenBlinkData?.progressPatientName}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ), //Bottom Widget
        ]));
  }

//TODO need optimization
  _buildTokens(DoctorState state, double sWidth, int dIndex) {
    var doctor = state.data2!.doctors![dIndex];

    var updatedTokens =
        doctor.tokens!.where((token) => token.calledFlag == 0).toList();

    return Expanded(
      flex: 4,
      child: Column(
        children: [
          _buildTokensHeader(sWidth),
          state.data2 != null
              ? Expanded(
                  child: ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: updatedTokens.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 40,
                      child: Row(children: [
                        Container(
                          width: sWidth * 0.66 * 0.03,
                        ),
                        SizedBox(
                          width: sWidth * 0.66 * 0.30,
                          child: Text('${updatedTokens[index].token}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstants.brownishGrey2)),
                        ),
                        SizedBox(
                          width: sWidth * 0.66 * 0.42,
                          child: Text('${updatedTokens[index].patientName}',
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstants.brownishGrey2)),
                        ),
                        SizedBox(
                          width: sWidth * 0.66 * 0.25,
                          child: Text(
                              updatedTokens[index].calledFlag == 0
                                  ? 'InQueue'
                                  : '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstants.brownishGrey2)),
                        ),
                      ]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ))
              : const SizedBox()
        ],
      ),
    );
  }

  _buildTokensHeader(double sWidth) {
    return Container(
      height: 40,
      color: ColorConstants.battleshipGrey,
      child: Row(children: [
        Container(
          width: sWidth * 0.66 * 0.03,
        ),
        SizedBox(
          width: sWidth * 0.66 * 0.30,
          child: const Text('Token',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white)),
        ),
        SizedBox(
          width: sWidth * 0.66 * 0.42,
          child: const Text('Patient Name',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white)),
        ),
        SizedBox(
          width: sWidth * 0.66 * 0.25,
          child: const Text('Status',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white)),
        ),
      ]),
    );
  }
}
