import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/otp/bloc/otp_event.dart';

import '../../config/color_constants.dart';
import '../../config/session_manager.dart';
import '../bloc/otp_bloc.dart';
import '../bloc/otp_state.dart';

class OtpBody extends StatelessWidget {
  const OtpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(listener: (context, state) async {
      if (state.status == OtpStatus.isFalse) {
        Navigator.pushNamedAndRemoveUntil(context, "/token", (Route route) => false);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, "/doctor", (Route route) => false);

        // final value=await SessionManager().getDoctorScreenType();
        // switch (value) {
        //   case ' Single Doctor':
        //     Navigator.pushNamedAndRemoveUntil(
        //         context, "/doctor", (Route route) => false);
        //     return;
        //   case ' Three Doctors':
        //     Navigator.pushNamedAndRemoveUntil(
        //         context, "/three-doctors", (Route route) => false);
        //     return;
        //   case ' Multiple Doctors':
        //     Navigator.pushNamedAndRemoveUntil(
        //         context, "/multiple-doctors", (Route route) => false);
        //     return;
        // }
        // Navigator.pushNamedAndRemoveUntil(
        //     context, "/doctor", (Route route) => false);
      }
      if (state.status == OtpStatus.isTrue) {
        Timer(const Duration(seconds: 6), () {
          BlocProvider.of<OtpBloc>(context).add(const OtpFetchEvent());
        });
      }
    }, builder: (context, state) {
      // if (state.status == OtpStatus.loading) {
      //   return const CircularProgressIndicator(
      //     color: ColorConstants.appRed,
      //   );
      // }
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/images/ic_app_logo.png',
                height: 65, fit: BoxFit.cover),
          ),
          const Spacer(),
          state.status == OtpStatus.loading
              ? const CircularProgressIndicator(
                  color: ColorConstants.appRed,
                )
              : Text(state.otp,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: ColorConstants.brownishGrey)),
          const SizedBox(
            height: 6,
          ),
          const Text(
              "Login into dashboard. From “Devices” option add this code to pair the devices.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: ColorConstants.brownishGrey)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/images/ic_app_logo.png',
                height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
  }
}
