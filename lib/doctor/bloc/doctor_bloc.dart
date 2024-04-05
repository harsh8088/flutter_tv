import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/doctor/bloc/doctor_state.dart';
import 'package:flutter_tv/doctor/model/blink_token_data.dart';
import 'package:flutter_tv/doctor/model/practice_response.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      // final response = await repository.getDisplayServices(
      //     deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      // print(response);
      // final otpResponse = DoctorResponse.fromJson(response);
      final response = await getDoctorsDummyData();
      var doctorDisplayIndex = state.doctorIndex.toInt();
      if (doctorDisplayIndex >= (response.doctors!.length - 1)) {
        doctorDisplayIndex = 0;
      } else {
        doctorDisplayIndex++;
      }

      //
      var tokens = response.doctors![doctorDisplayIndex].tokens;

      var isPlay = false;
      List<int> blinkTokens = List<int>.empty(growable: true);
      var sharedPref = await SharedPreferences.getInstance();

      var isInProgress = false;
      var inProgressToken = "";
      var inProgressPatientName = "";

      tokens?.forEach((it) {
        if (it.calledFlag == 1) {
          isInProgress = true;
          inProgressToken = it.token!;
          inProgressPatientName = it.patientName!;

          var sharedIdValue = sharedPref.getInt(it.token!) ?? 0;
          if (sharedIdValue == 0) {
            sharedPref.setInt(it.token!, it.id!);
            sharedPref.setInt(
                '${it.id!}_${it.calledTokenCount!}', it.calledTokenCount!);

            blinkTokens.add(it.id!);
            isPlay = true;
          } else {
            var tokenCalledValue =
                sharedPref.getInt('${it.id!}_${it.calledTokenCount!}') ?? 0;
            if (tokenCalledValue != it.calledTokenCount) {
              sharedPref.setInt(
                  '${it.id!}_${it.calledTokenCount!}', it.calledTokenCount!);
              blinkTokens.add(it.id!);
              isPlay = true;
            }
          }
        } else {
          var sharedIdValue = sharedPref.getInt(it.token!) ?? 0;
          //remove token from local storage
          if (sharedIdValue > 0) {
            sharedPref.remove('${it.id!}');
          }
        }
      });

      var json = {
        "progressToken": inProgressToken,
        "progressPatientName": inProgressPatientName,
        "blinkToken": isPlay
      };
      print('json');
      print(json);

      emit(state.copyWith(
          status: FormzStatus.pure,
          data: [response],
          data2: response,
          doctorIndex: doctorDisplayIndex,
          progressToken: inProgressToken,
          progressPatientName: inProgressPatientName,
          tokenBlinkData: TokenBlinkData.fromJson(json),
          blinkToken: isPlay));
    } catch (_) {
      print(_.toString());
    }
  }

  void _onDoctorPracticeFetchEvent(DoctorPracticeFetchEvent event,
      Emitter<DoctorState> emit) async {
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

  void _onDoctorThreeFetchEvent(DoctorEvent event,
      Emitter<DoctorState> emit) async {
    try {
      // emit(state.copyWith(
      //   status: FormzStatus.submissionInProgress,
      // ));

      // final response = await repository.getDisplayServices(
      //     deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      // print(response);
      // final otpResponse = DoctorResponse.fromJson(response);
      final otpResponse = await getDoctorsDummyData();

      final doctorInProgress = await getDoctorInProgress(otpResponse);

      final   (doctorResponse, index)  =
      await getFilteredDoctors(doctorInProgress, state.doctorIndex);
      print("updatedIndex:$index");
      print("doctorres:${doctorResponse.doctors!.length}");
      print("doctorrestoken:${doctorResponse.doctors![0].tokens!.length}");


      emit(state.copyWith(
          status: FormzStatus.pure,
          data: [doctorResponse],
          data2: doctorResponse,
          doctorIndex: index));
    } catch (_) {
      print(_.toString());
    }
  }

  void _onDoctorMultipleFetchEvent(DoctorEvent event,
      Emitter<DoctorState> emit) async {
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

  //get in progress or queue doctors
  Future<DoctorResponse> getDoctorInProgress(DoctorResponse doctorRes) async {
    try {
      print('getDoctorsInProgress:before:${doctorRes.doctors?.length}');
      final result = doctorRes.doctors?.map((it) {
        return it.copyWith(
          tokens: it.tokens?.where((token) => token.calledFlag == 1).toList(),
          queueTokens:
          it.tokens?.where((token) => token.calledFlag == 0).toList(),
        );
      }).toList();
      final resul = result
          ?.toSet()
          .toList()
          .where((it) => it.queueTokens!.isNotEmpty || it.tokens!.isNotEmpty)
          .toList();
      final updatedDoctorRes = doctorRes.copyWith(doctors: resul);
      print('getDoctorsInProgress:after:${updatedDoctorRes.doctors!.length}');
      print('updatedRes: '+jsonEncode(updatedDoctorRes));
      return updatedDoctorRes;
    } catch (e, stackTrace) {
      print(stackTrace);
      return doctorRes;
    }
  }

  Future<(DoctorResponse, int)> getFilteredDoctors(DoctorResponse doctorRes,
      int doctorDisplayIndex) async {
    try {
      if (doctorDisplayIndex == -1) doctorDisplayIndex = 0;
      print(
          'doctorDisplayIndex:$doctorDisplayIndex,doctorSize:${doctorRes
              .doctors!.length}');
      if ((doctorDisplayIndex + 3) < doctorRes.doctors!.length) {
        final filteredDoctors = doctorRes.doctors!
            .sublist(doctorDisplayIndex, doctorDisplayIndex + 3);
        final updatedDoctorRes = doctorRes.copyWith(doctors: filteredDoctors);
        doctorDisplayIndex += 3;
        return (updatedDoctorRes, doctorDisplayIndex);
      } else {
        final filteredDoctors = doctorRes.doctors!.sublist(doctorDisplayIndex);
        final updatedDoctorRes = doctorRes.copyWith(doctors: filteredDoctors);
        doctorDisplayIndex = 0;
        return (updatedDoctorRes, doctorDisplayIndex);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      doctorDisplayIndex = 0;
      return (doctorRes, doctorDisplayIndex);
    }
  }
}
