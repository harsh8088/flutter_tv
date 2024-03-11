import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/doctor/bloc/doctor_state.dart';
import 'package:flutter_tv/doctor/model/practice_response.dart';
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
    on<DoctorPracticeFetchEvent>(_onDoctorPracticeFetchEvent);
    on<DoctorThreeFetchEvent>(_onDoctorThreeFetchEvent);
    on<DoctorMultipleFetchEvent>(_onDoctorMultipleFetchEvent);
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
      final otpResponse = await getDoctorsDummyData();

      emit(state.copyWith(status: FormzStatus.pure, data: [otpResponse]));
    } catch (_) {
      print(_.toString());
    }
  }

  void _onDoctorPracticeFetchEvent(
      DoctorPracticeFetchEvent event, Emitter<DoctorState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      // event.hospitalId;
      // event.doctorId
      //TODO Get param values from event
      final response =
          await repository.getPracticeStatus(hospitalId: 0, doctorId: 0);
      print(response);
      // final otpResponse = DoctorResponse.fromJson(response);
      final otpResponse = await getPracticeDummyData();

      emit(state.copyWith(
        status: FormzStatus.pure,
      ));
    } catch (_) {
      print(_.toString());
    }
  }

  void _onDoctorThreeFetchEvent(
      DoctorEvent event, Emitter<DoctorState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      final response = await repository.getDisplayServices(
          deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      print(response);
      // final otpResponse = DoctorResponse.fromJson(response);
      final otpResponse = await getDoctorsDummyData();

      emit(state.copyWith(status: FormzStatus.pure, data: [otpResponse]));
    } catch (_) {
      print(_.toString());
    }
  }

  void _onDoctorMultipleFetchEvent(
      DoctorEvent event, Emitter<DoctorState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      final response = await repository.getDisplayServices(
          deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      print(response);
      // final otpResponse = DoctorResponse.fromJson(response);
      final otpResponse = await getDoctorsDummyData();

      emit(state.copyWith(status: FormzStatus.pure, data: [otpResponse]));
    } catch (_) {
      print(_.toString());
    }
  }

  Future<DoctorResponse> getDoctorsDummyData() async {
    String data = await rootBundle.loadString("assets/doctor_list_new.json");
    var map = jsonDecode(data);
    return DoctorResponse.fromJson(map);
  }

  Future<PracticeResponse> getPracticeDummyData() async {
    var list = ['Y', 'N'];
    list.elementAt(Random().nextInt(list.length));
    var map = {
      'status': true,
      'message': '',
      'is_practicing': list.elementAt(Random().nextInt(list.length))
    };
    return PracticeResponse.fromJson(map);
  }
}
