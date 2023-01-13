import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/token/bloc/token_event.dart';
import 'package:flutter_tv/token/bloc/token_state.dart';
import 'package:formz/formz.dart';

import '../../config/constants.dart';
import '../../repository/my_requests_repository.dart';
import '../model/token_response.dart';

class TokenBloc extends Bloc<OtpEvent, TokenState> {
  final MyRequestRepository repository;
  int page = 1;
  bool isFetching = false;

  TokenBloc({
    required this.repository,
  }) : super(const TokenState()) {
    on<TokenFetchEvent>(_onTokenFetchEvent);
  }

  void _onTokenFetchEvent(OtpEvent event, Emitter<TokenState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      final response = await repository.getDisplayServices(
          deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      print(response);
      final otpResponse = TokenResponse.fromJson(response);
      emit(state.copyWith(status: FormzStatus.pure, data: [otpResponse]));
    } catch (_) {
      print(_.toString());
    }
  }
}
