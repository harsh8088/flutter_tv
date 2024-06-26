import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/doctor/bloc/doctor_bloc.dart';
import 'package:flutter_tv/doctor/view/doctor_three_body.dart';

import '../repository/my_requests_repository.dart';
import 'bloc/doctor_event.dart';

class DoctorThree extends StatelessWidget {
  const DoctorThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => DoctorBloc(
                  repository: MyRequestRepository(),
                )..add(const DoctorThreeFetchEvent()),
            child: const DoctorThreeBody()));
  }
}
