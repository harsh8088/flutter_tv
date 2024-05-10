import 'package:equatable/equatable.dart';
import 'package:flutter_tv/doctor/model/blink_token_data.dart';
import 'package:flutter_tv/doctor/model/doctor_response.dart';

import '../../networking/response.dart';

class DoctorState extends Equatable {
  const DoctorState({
    this.status = EventStatus.initial,
    this.message = "",
    this.data = const [],
    this.data2,
    this.blinkToken = false,
    this.progressToken = '',
    this.progressPatientName = '',
    this.tokenBlinkData,
    this.doctorIndex = -1,
  });

  final EventStatus status;
  final String message;
  final List<DoctorResponse> data;
  final DoctorResponse? data2;
  final int doctorIndex;
  final bool blinkToken;
  final String progressToken;
  final String progressPatientName;
  final TokenBlinkData? tokenBlinkData;

  DoctorState copyWith(
      {EventStatus? status,
      String? message,
      List<DoctorResponse>? data,
      DoctorResponse? data2,
      bool? blinkToken,
      String? progressToken,
      String? progressPatientName,
      TokenBlinkData? tokenBlinkData,
      int? doctorIndex}) {
    return DoctorState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        data2: data2 ?? this.data2,
        tokenBlinkData: tokenBlinkData ?? this.tokenBlinkData,
        doctorIndex: doctorIndex ?? this.doctorIndex);
  }

  @override
  List<Object> get props => [status, message, data, doctorIndex];
}
