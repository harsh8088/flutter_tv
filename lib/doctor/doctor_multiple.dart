import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/doctor/bloc/doctor_bloc.dart';
import 'package:flutter_tv/doctor/view/doctor_body.dart';
import 'package:flutter_tv/doctor/view/doctor_multiple_body.dart';

import '../repository/my_requests_repository.dart';
import 'bloc/doctor_event.dart';

class DoctorMultiple extends StatelessWidget {
  const DoctorMultiple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => DoctorBloc(
                  repository: MyRequestRepository(),
                )..add(const DoctorMultipleFetchEvent()),
            child: const DoctorMultipleBody()));
  }
}
