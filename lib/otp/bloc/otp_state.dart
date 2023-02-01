import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  const OtpState({
    this.status = OtpStatus.pure,
    this.message = "",
    this.otp = "",
  });

  final OtpStatus status;
  final String message;
  final String otp;

  OtpState copyWith({OtpStatus? status, String? message, String? otp}) {
    return OtpState(
        status: status ?? this.status,
        message: message ?? this.message,
        otp: otp ?? this.otp);
  }

  @override
  List<Object> get props => [status, message, otp];
}

enum OtpStatus { pure, loading, isTrue, isFalse }
