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
import 'doctor_drop_down.dart';
import 'doctor_status.dart';

class DoctorThreeBody extends StatelessWidget {
  const DoctorThreeBody({super.key});

  @override
  Widget build(BuildContext context) {
    print("width");
    print(MediaQuery.of(context).size.width);
    print("updatedWidth");
    print(MediaQuery.of(context).size.width * 0.33 * 2);
    var sWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<DoctorBloc, DoctorState>(
        listener: (context, state) {
          // if (state is SuccessState) {
          //   if (state.isPinAvailable)
          //     Navigator.pushNamed(context, "/login-pin").then((value) => _refreshState());
          //   else
          //     Navigator.pushNamed(context, "/otp");
          // }

          if (state.data.isNotEmpty && state.data[0].deviceType == 4) {
            //NurseTokens
            return;
          }
          if (state.data.isNotEmpty &&
              state.data[0].deviceType == 2 &&
              state.status == FormzStatus.pure) {
            //DoctorTokens
            Timer(const Duration(seconds: 6), () {
              if (context.mounted) {
                BlocProvider.of<DoctorBloc>(context)
                    .add(const DoctorThreeFetchEvent());
              }
            });
            return;
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(state),
              _buildThreeDoctors(state),
              _buildFooter(state)
            ],
          );
        });
  }

  Widget _buildThreeDoctors(DoctorState state) {
    print("fNdatalen: ${state.data.length}");
    if (state.data.isNotEmpty) {
      print("fNdata: ${state.data[0].doctors!.length}");
      print("fNdata2: ${state.data2!.doctors!.length}");

      return Expanded(
        child: Container(
          color: ColorConstants.backgroundColor,
          child: Row(
            children: [
              _buildEachDoctor(state, 0),
              const SizedBox(
                width: 5,
              ),
              state.data2!.doctors!.length > 1
                  ? _buildEachDoctor(state, 1)
                  : _buildEmptyDoctor(state),
              const SizedBox(
                width: 5,
              ),
              state.data2!.doctors!.length > 2
                  ? _buildEachDoctor(state, 2)
                  : _buildEmptyDoctor(state),
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          color: ColorConstants.backgroundColor,
        ),
      );
    }
  }

  Widget _buildEachDoctor(DoctorState state, int index) {
    return Expanded(
        flex: 1,
        child: Container(
          color: ColorConstants.slateTwo,
          child: Column(children: [
            Expanded(
              flex: 4,
              child: Container(
                child: state.data.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 10),
                          Text(state.data[0].doctors![index].firstName!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white)),
                          Text(
                              '${state.data[0].doctors![index].specialities?.join(', ')}',
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
                              Text(
                                  "${state.data[0].doctors![index].room?.name!}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white)),
                              const SizedBox(
                                width: 15,
                              ),
                              DoctorStatusWidget(
                                  hospitalId: state.data[0].hospital!.id!,
                                  doctorId: state.data[0].doctors![index].id!),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    SizedBox(
                      height: 6,
                    ),
                    Text("In Progress",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: ColorConstants.bottomHeader)),
                    SizedBox(
                      height: 4,
                    ),
                    Text("A 0034",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: ColorConstants.brownishGrey)),
                  ],
                ),
              ),
            ),
            const Text("In Queue",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white)),
            Expanded(
              flex: 5,
              child: Container(
                color: ColorConstants.battleshipGrey,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Text("A 003$index",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.white));
                    }),
              ),
            ),
          ]),
        ));
  }

  Widget _buildEmptyDoctor(DoctorState state) {
    return Expanded(flex: 1, child: Container());
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
          child: Text("Doctor Three",
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

  _buildFooter(DoctorState state) {
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
