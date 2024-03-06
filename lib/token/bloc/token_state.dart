import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../model/token_response.dart';

class TokenState extends Equatable {
  const TokenState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data = const [],
      this.tokens = const [],
      this.blinkTokens = const [],
      this.isPlay = false});

  final FormzStatus status;
  final String message;
  final List<TokenResponse> data;
  final List<Tokens> tokens;
  final List<int> blinkTokens;
  final bool isPlay;

  TokenState copyWith(
      {FormzStatus? status,
      String? message,
      List<TokenResponse>? data,
      List<Tokens>? tokens,
      List<int>? blinkTokens,
      bool? isPlay}) {
    return TokenState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        tokens: tokens ?? this.tokens,
        blinkTokens: blinkTokens ?? this.blinkTokens,
        isPlay: isPlay ?? this.isPlay);
  }

  @override
  List<Object> get props =>
      [status, message, data, tokens, blinkTokens, isPlay];
}
