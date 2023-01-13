import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../model/token_response.dart';

class TokenState extends Equatable {
  const TokenState(
      {this.status = FormzStatus.valid,
      this.message = "",
      this.data = const []});

  final FormzStatus status;
  final String message;
  final List<TokenResponse> data;

  TokenState copyWith(
      {FormzStatus? status, String? message, List<TokenResponse>? data}) {
    return TokenState(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  @override
  List<Object> get props => [status, message, data];
}
