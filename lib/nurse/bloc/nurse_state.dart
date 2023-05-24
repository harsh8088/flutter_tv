import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../model/nurse_response.dart';

class NurseState extends Equatable {
  const NurseState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data = const [],
      this.services = const [],
      this.isPlay = true});

  final FormzStatus status;
  final String message;
  final List<NurseResponse> data;
  final List<Tokens> services;
  final bool isPlay;

  NurseState copyWith(
      {FormzStatus? status,
      String? message,
      List<NurseResponse>? data,
      List<Tokens>? services,
      bool? isPlay}) {
    return NurseState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        services: services ?? this.services,
        isPlay: isPlay ?? this.isPlay);
  }

  @override
  List<Object> get props => [status, message, data, services, isPlay];
}
