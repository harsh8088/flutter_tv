import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../model/nurse_response.dart';

class NurseState extends Equatable {
  const NurseState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data,
      this.tokens = const [],
      this.blinkTokens = const {},
      this.isPlay = true});

  final FormzStatus status;
  final String message;
  final NurseResponse? data;
  final List<Tokens> tokens;
  final Map<String, int> blinkTokens;
  final bool isPlay;

  NurseState copyWith(
      {FormzStatus? status,
      String? message,
      NurseResponse? data,
      List<Tokens>? tokens,
      Map<String, int>? blinkTokens,
      bool? isPlay}) {
    return NurseState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        tokens: tokens ?? this.tokens,
        blinkTokens: blinkTokens ?? this.blinkTokens,
        isPlay: isPlay ?? this.isPlay);
  }

  @override
  List<Object?> get props =>
      [status, message, data, tokens, blinkTokens, isPlay];
}
