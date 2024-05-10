import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/session_manager.dart';

import '../../networking/response.dart';
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
        status: EventStatus.inProgress,
      ));

      // final response = await repository.getDisplayServices(
      //     deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);
      // print(response);
      // final otpResponse = NurseResponse.fromJson(response);

      final nurseResponse = await getDummyData();
      print("nursetokens: ${nurseResponse.tokens?.length}");

      var blinkMap = <String, int>{};
      var play = false;
      final tokens = nurseResponse.tokens!;
      for (var token in tokens) {
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
      if (tokens.length >= 14) {
        tokens.sublist(0, 13);
      }

      // perform actions on response
      print("BlinkMap${blinkMap.length}");

      emit(state.copyWith(
          status: EventStatus.completed,
          data: nurseResponse,
          tokens: tokens,
          blinkTokens: blinkMap,
          isPlay: play));
    } catch (_) {
      print("Error$_");
      emit(state.copyWith(status: EventStatus.completed));
    }
  }

  Future<NurseResponse> getDummyData() async {
    // String data = await rootBundle.loadString("assets/nurse_tokens.json");
    // var map = jsonDecode(data);
    // return NurseResponse.fromJson(map);

    var random = Random();
    var jsonList = <Map<String, dynamic>>[];

    List<String> statusValues = ["Nurse Assessment", ""];
    List<int> statusKeys = [1, 0, 0, 0, 0];

    for (int i = 0; i < 14; i++) {
      var id = 20 + i; // Incrementing ID
      var index = random.nextInt(2);
      var jsonItem = {
        "id": id,
        "token": "A ${random.nextInt(100).toString().padLeft(3, '0')}",
        "service_name": random.nextInt(100).toString(),
        "counter": "Counter_${random.nextInt(100)}",
        "called": statusValues[index],
        "called_flag": statusKeys[index],
        "called_token_count": random.nextInt(100),
        "patient_name": "Patient_${random.nextInt(100)}",
        "uhid": "SW01.${random.nextInt(100).toString().padLeft(10, '0')}"
      };
      jsonList.add(jsonItem);
    }

    jsonList;

    var res = {
      "device_type": 4,
      "scroll_text": "Please expect some delay if doctor is busy",
      "scroll_text_en":
          "Please expect some delay if doctor is busy, you will be called shortly",
      "missed_text": "Missed",
      "missed_text_en": "Missed Token",
      "tokens": jsonList,
      "hospital": {
        "name": "ILS Hospital",
        "id": 51,
        "address":
            "52\/2 & 52\/3, Deverabeesanahalli, Opposite INTEL, Outer Ring Road",
        "hospital_logo":
            "https:\/\/\/uploads\/hospitals\/2022\/2\/164537127116452714971639740554SakraLogo.png",
        "floor": {"name": "First Floor", "id": 1}
      }
    };

    return NurseResponse.fromJson(res);
  }
}
