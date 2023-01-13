import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/otp/bloc/otp_event.dart';

import '../../config/color_constants.dart';
import '../bloc/otp_bloc.dart';
import '../bloc/otp_state.dart';

class OtpBody extends StatelessWidget {
  const OtpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(listener: (context, state) {
      if (state.status == OtpStatus.isTrue) {
        Navigator.pushNamed(context, "/token");
      }
      if (state.status == OtpStatus.isFalse) {
        Timer(const Duration(seconds: 6), () {
          BlocProvider.of<OtpBloc>(context).add(const OtpFetchEvent());
        });
      }
    }, builder: (context, state) {
      if (state.status == OtpStatus.loading) {
        return const CircularProgressIndicator(
          color: ColorConstants.appRed,
        );
      }
      return Container(
        child: Center(
          child: Text(state.otp),
        ),
      );
    });
  }
}
