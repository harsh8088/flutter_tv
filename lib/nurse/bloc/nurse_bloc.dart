import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/session_manager.dart';
import 'package:formz/formz.dart';

import '../../config/constants.dart';
import '../../repository/my_requests_repository.dart';
import '../model/nurse_response.dart';
import 'nurse_event.dart';
import 'nurse_state.dart';

class NurseBloc extends Bloc<NurseEvent, NurseState> {
  final MyRequestRepository repository;
  int page = 1;
  bool isFetching = false;

  NurseBloc({
    required this.repository,
  }) : super(const NurseState()) {
    on<NurseFetchEvent>(_onNurseFetchEvent);
  }

  void _onNurseFetchEvent(NurseEvent event, Emitter<NurseState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      final response = await repository.getDisplayServices(
          deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      print(response);
      final otpResponse = NurseResponse.fromJson(response);

      var blinkMap = <String, int>{};
      var play = false;
      final services = otpResponse.tokens!;
      for (var token in services) {
        if (token.calledFlag == 1) {
          var sharedIdValue =
              await SessionManager().getNurseToken(token.id.toString());
          if (sharedIdValue == null) {
            //add token in ls
            await SessionManager()
                .setNurseToken(token.id.toString(), token.id!);
            await SessionManager().setNurseToken(
                "${token.id}_${token.calledTokenCount}",
                token.calledTokenCount!);
            blinkMap[token.id.toString()] = token.id!;
            play = true;
          } else {
            var tokenCalledValue = await SessionManager()
                .getNurseToken("${token.id}_${token.calledTokenCount}");
            if (tokenCalledValue != null &&
                tokenCalledValue != token.calledTokenCount) {
              await SessionManager().setNurseToken(
                  "${token.id}_${token.calledTokenCount}",
                  token.calledTokenCount!);
              blinkMap[token.id.toString()] = token.id!;
              play = true;
            }
          }
        } else {
          var sharedIdValue =
              await SessionManager().getNurseToken(token.id.toString());
          if (sharedIdValue != null) {
            await SessionManager().removeNurseToken(token.id.toString());
          }
        }
      }
      if (services.length >= 14) {
        services.sublist(0, 13);
      }

      // perform actions on response

      emit(state.copyWith(
          status: FormzStatus.pure,
          data: [otpResponse],
          services: services,
          isPlay: play));
    } catch (_) {
      print(_.toString());
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
