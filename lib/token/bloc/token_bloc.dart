import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/config/session_manager.dart';
import 'package:flutter_tv/token/bloc/token_event.dart';
import 'package:flutter_tv/token/bloc/token_state.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants.dart';
import '../../repository/my_requests_repository.dart';
import '../model/token_response.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final MyRequestRepository repository;
  int page = 1;
  bool isFetching = false;

  TokenBloc({
    required this.repository,
  }) : super(const TokenState()) {
    on<TokenFetchEvent>(_onTokenFetchEvent);
    on<AllTokensFetchEvent>(_onAllTokensFetchEvent);
  }

  void _onTokenFetchEvent(TokenEvent event, Emitter<TokenState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      // final response = await repository.getDisplayServices(
      //     deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);

      final String strResponse =
          await rootBundle.loadString('assets/counter_list.json');
      final response = await json.decode(strResponse);

      print(response);
      final tokenResponse = TokenResponse.fromJson(response);

      var sharedPref = await SharedPreferences.getInstance();
      // var finalServices = tokenResponse.tokens;

      //Getting random item from the response
      var finalServices = List<Tokens>.empty(growable: true);
      finalServices.add(tokenResponse.tokens!
          .elementAt(Random().nextInt(tokenResponse.tokens!.length)));

      var savedCounter =
          await SessionManager().getSavedCounterList(Constants.keyCounters);

      var copyCounter = savedCounter.toList(growable: true);
      print("copyCounter:$copyCounter");
      if (finalServices!.isNotEmpty) {
        finalServices.forEach((element) {
          if (savedCounter.contains(element.counter)) {
            copyCounter.remove(element.counter);
          } else {
            savedCounter.add(element.counter!);
          }
        });
      }
      await SessionManager().setSavedCounterList(savedCounter);

      var isPlay = false;
      List<int> blinkTokens = List<int>.empty(growable: true);

      finalServices.forEach((it) {
        var key = it.counter! + it.token!;
        var sharedIdValue = sharedPref.getInt(it.counter! + it.token!) ?? 0;
        if (it.calledFlag == 1) {
          if (sharedIdValue == 0) {
            sharedPref.setInt(it.counter! + it.token!, it.id!);
            blinkTokens.add(it.id!);
            isPlay = true;
          }
        } else {
          if (sharedIdValue > 0) {
            sharedPref.remove(it.counter! + it.token!);
          }
        }
      });

      copyCounter.forEach((element) {
        finalServices.add(Tokens(
          counter: element,
          token: '',
          id: 0,
        ));
      });
      finalServices
          .sort((item1, item2) => item1.counter!.compareTo(item2.counter!));

      print('finalServices:${finalServices}');
      print('copyCounter:${copyCounter}');
      print('blinkTokens:${blinkTokens}');

      emit(state.copyWith(
          status: FormzStatus.pure,
          data: [tokenResponse],
          tokens: finalServices.toList(),
          blinkTokens: blinkTokens,
          isPlay: isPlay));
    } catch (_) {
      print(_.toString());
    }
  }

  void _onAllTokensFetchEvent(
      TokenEvent event, Emitter<TokenState> emit) async {
    try {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
      ));

      // final response = await repository.getDisplayServices(
      //     deviceId: Constants.deviceID, deviceModel: Constants.deviceModel);

      final String strResponse =
          await rootBundle.loadString('assets/counter_list.json');
      final response = await json.decode(strResponse);

      print(response);
      final otpResponse = TokenResponse.fromJson(response);

      var sharedPref = await SharedPreferences.getInstance();
      var finalServices = otpResponse.tokens;

      // var list = ['a', 'b', 'c', 'd', 'e'];
      // list.elementAt(Random().nextInt(list.length));
      //
      // var finalServices = List<Tokens>.empty(growable: true);
      // finalServices.add(otpResponse.tokens!
      //     .elementAt(Random().nextInt(otpResponse.tokens!.length)));

      var isPlay = false;
      List<int> blinkTokens = List<int>.empty(growable: true);

      finalServices?.forEach((it) {
        var key = it.counter! + it.token!;
        var sharedIdValue = sharedPref.getInt(it.counter! + it.token!) ?? 0;
        if (it.calledFlag == 1) {
          if (sharedIdValue == 0) {
            sharedPref.setInt(it.counter! + it.token!, it.id!);
            blinkTokens.add(it.id!);
            isPlay = true;
          }
        } else {
          if (sharedIdValue > 0) {
            sharedPref.remove(it.counter! + it.token!);
          }
        }
      });

      // copyCounter.forEach((element) {
      //   finalServices.add(Tokens(
      //     counter: element,
      //     id: 0,
      //   ));
      // });
      // finalServices
      //     .sort((item1, item2) => item1.counter!.compareTo(item2.counter!));

      print('finalServices:${finalServices}');
      // print('copyCounter:${copyCounter}');
      print('blinkTokens:${blinkTokens}');

      emit(state.copyWith(
          status: FormzStatus.pure,
          data: [otpResponse],
          tokens: finalServices?.toList(),
          blinkTokens: blinkTokens,
          isPlay: isPlay));
    } catch (_) {
      print(_.toString());
    }
  }
}
