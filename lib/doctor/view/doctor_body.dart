import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/app_utils.dart';
import 'package:flutter_tv/config/color_constants.dart';
import 'package:flutter_tv/doctor/bloc/doctor_event.dart';
import 'package:flutter_tv/doctor/bloc/doctor_state.dart';
import 'package:formz/formz.dart';
import 'package:marquee/marquee.dart';

import '../bloc/doctor_bloc.dart';

class DoctorBody extends StatelessWidget {
  const DoctorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorBloc, DoctorState>(listener: (context, state) {
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
          BlocProvider.of<DoctorBloc>(context).add(const DoctorFetchEvent());
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
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: ColorConstants.slateTwo,
                          child: Column(children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                width: double.infinity,
                                color: ColorConstants.battleshipGrey,
                                child: ListView(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Image.asset(
                                            'assets/images/ic_mhc_logo.png',
                                            height: 70,
                                            fit: BoxFit.cover),
                                        const SizedBox(height: 10),
                                        const Text("Dr. Test Doctor",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.white)),
                                        const Text(
                                            "Urology & Renal Transplant Surgery",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 22,
                                                color: Colors.white)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                             const Text("9 AM - 11 AM",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 21,
                                                    color: Colors.white)),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 4.0, bottom: 4.0),
                                                  child: Text("OUT",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.green)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Room 11",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListView(
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("In Progress",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: ColorConstants
                                              .titleHeaderYellow)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("A 0034",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Patient Name Patient Name Patient Name",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                            color: Colors.white)),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        )),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            color: ColorConstants.battleshipGrey,
                            child: Row(children: const [
                              Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),
                              Text('Token',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.white)),
                              Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Text('Patient Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.white)),
                              Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),
                              Text('Status',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.white)),
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
                              return Container(
                                height: 40,
                                child: Row(children: [
                                  const Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                  Text('Token $index',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          color: ColorConstants.brownishGrey2)),
                                  const Expanded(
                                    flex: 3,
                                    child: SizedBox(),
                                  ),
                                  Text('Patient Name $index',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          color: ColorConstants.brownishGrey2)),
                                  const Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                  Text('Status $index',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          color: ColorConstants.brownishGrey2)),
                                  const Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                ]),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ))
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Container(child: _buildFooter())
          // _buildFooter()
        ],
      );
    });
  }

  _buildHeader(DoctorState state) {
    return Row(
      children: [
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/images/ic_sps_logo.png',
              height: 40, fit: BoxFit.cover),
        )),
        const Spacer(),
        const Text("Doctor One",
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
