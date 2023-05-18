import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/doctor/bloc/doctor_state.dart';
import 'package:formz/formz.dart';

import '../../config/constants.dart';
import '../../repository/my_requests_repository.dart';
import '../model/doctor_response.dart';
import 'doctor_event.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final MyRequestRepository repository;
  int page = 1;
  bool isFetching = false;

  DoctorBloc({
    required this.repository,
  }) : super(const DoctorState()) {
    on<DoctorFetchEvent>(_onDoctorFetchEvent);
  }

  void _onDoctorFetchEvent(DoctorEvent event, Emitter<DoctorState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      final response = await repository.getDisplayServices(
          deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      print(response);
      // final otpResponse = DoctorResponse.fromJson(response);
      final otpResponse = await getDummyData();

      emit(state.copyWith(status: FormzStatus.pure, data: [otpResponse]));
    } catch (_) {
      print(_.toString());
    }
  }

  Future<DoctorResponse> getDummyData() async {
    String data = await rootBundle.loadString("assets/doctor_list_new.json");
    var map = jsonDecode(data);
    return DoctorResponse.fromJson(map);
  }
}
