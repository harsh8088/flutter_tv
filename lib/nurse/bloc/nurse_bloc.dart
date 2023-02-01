import 'package:flutter_bloc/flutter_bloc.dart';
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

      //perform actions on response

      emit(state.copyWith(status: FormzStatus.pure, data: [otpResponse]));
    } catch (_) {
      print(_.toString());
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
