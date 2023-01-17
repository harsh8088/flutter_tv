import 'package:equatable/equatable.dart';
import 'package:flutter_tv/doctor/model/doctor_response.dart';
import 'package:formz/formz.dart';

class DoctorState extends Equatable {
  const DoctorState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data = const []});

  final FormzStatus status;
  final String message;
  final List<DoctorResponse> data;

  DoctorState copyWith(
      {FormzStatus? status, String? message, List<DoctorResponse>? data}) {
    return DoctorState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  @override
  List<Object> get props => [status, message, data];
}
