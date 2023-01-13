import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/otp/bloc/otp_event.dart';
import 'package:flutter_tv/otp/view/otp_body.dart';

import '../repository/my_requests_repository.dart';
import 'bloc/otp_bloc.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => OtpBloc(
                  repository: MyRequestRepository(),
                )..add(const OtpFetchEvent()),
            child: const Center(
              child: OtpBody(),
            )));
  }
}
