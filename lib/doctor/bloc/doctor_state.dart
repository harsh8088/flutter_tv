import 'package:equatable/equatable.dart';
import 'package:flutter_tv/doctor/model/doctor_response.dart';
import 'package:formz/formz.dart';

class DoctorState extends Equatable {
  const DoctorState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data = const [],
      this.data2});

  final FormzStatus status;
  final String message;
  final List<DoctorResponse> data;
  final DoctorResponse? data2;

  DoctorState copyWith(
      {FormzStatus? status,
      String? message,
      List<DoctorResponse>? data,
      DoctorResponse? data2}) {
    return DoctorState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        data2: data2 ?? this.data2);
  }

  @override
  List<Object> get props => [status, message, data];
}
