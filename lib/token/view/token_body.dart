import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:marquee/marquee.dart';

import '../../config/color_constants.dart';
import '../bloc/token_bloc.dart';
import '../bloc/token_event.dart';
import '../bloc/token_state.dart';

class TokenBody extends StatelessWidget {
  const TokenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TokenBloc, TokenState>(listener: (context, state) {
      // if (state is SuccessState) {
      //   if (state.isPinAvailable)
      //     Navigator.pushNamed(context, "/login-pin").then((value) => _refreshState());
      //   else
      //     Navigator.pushNamed(context, "/otp");
      // }
      if (state.data.isNotEmpty && state.data[0].deviceType == 2) {
        //DoctorTokens
        return;
      }
      if (state.data.isNotEmpty && state.data[0].deviceType == 4) {
        //NurseTokens
        return;
      }
      if (state.data.isNotEmpty && state.status == FormzStatus.pure) {
        Timer(const Duration(seconds: 6), () {
          BlocProvider.of<TokenBloc>(context).add(const TokenFetchEvent());
        });
        return;
      }
    }, builder: (context, state) {
      // if (state.status.isSubmissionInProgress) {
      //   return const CircularProgressIndicator(
      //     color: ColorConstants.appRed,
      //   );
      // }
      return Column(
        children: [
          Container(
            child: _buildHeader(),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
          Container(color: Colors.grey, child: _buildFooter())
          // _buildFooter()
        ],
      );
    });
  }

  _buildHeader() {
    return Row(
      children: [
        Container(
            width: 80,
            child: Image.network(
                "https://cdn.pixabay.com/photo/2022/10/03/23/41/house-7497001_1280.png")),
        Spacer(),
        Text("Floor One",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black54)),
        Spacer(),
        Text("FRI,02:40 PM",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black54))
      ],
    );
  }

  _buildFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 80,
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: const Text("No Show Tokens",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white)),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            height: 40,
              child: Marquee(
                text: 'For a missed token number, please inform at billing counter and wait, you will be called shortly.',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.white),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 200.0,
                velocity: 100.0,
                pauseAfterRound: Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              )),
        ),
        Container(
          width: 80,
          color: Colors.grey,
          child: Image.network(
              "https://cdn.pixabay.com/photo/2022/10/03/23/41/house-7497001_1280.png"),
        ),
      ],
    );
  }
}
