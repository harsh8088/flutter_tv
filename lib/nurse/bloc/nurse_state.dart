import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../model/nurse_response.dart';

class NurseState extends Equatable {
  const NurseState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data = const []});

  final FormzStatus status;
  final String message;
  final List<NurseResponse> data;

  NurseState copyWith(
      {FormzStatus? status, String? message, List<NurseResponse>? data}) {
    return NurseState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  @override
  List<Object> get props => [status, message, data];
}
