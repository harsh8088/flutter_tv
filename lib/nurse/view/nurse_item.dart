import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/nurse/bloc/nurse_bloc.dart';
import 'package:flutter_tv/nurse/bloc/nurse_state.dart';

import '../../config/color_constants.dart';
import '../model/nurse_response.dart';
import 'nurse_blink.dart';

class NurseItem extends StatefulWidget {
  const NurseItem({Key? key}) : super(key: key);

  @override
  State<NurseItem> createState() => _NurseItemState();
}

class _NurseItemState extends State<NurseItem>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    try {
      if (audioPlayer.state != PlayerState.playing) {
        await audioPlayer.play(AssetSource('token_audio.mp3'),
            mode: PlayerMode.lowLatency);
      }
    } catch (_) {
      print(_.toString());
    }
  }

  Future<void> startScrolling() async {
    await Future.delayed(const Duration(seconds: 1));
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    await Future.delayed(const Duration(seconds: 2));
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Perform your task
    } else {
      print("maxScrollExtent:${scrollController.position.maxScrollExtent}");
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 4), curve: Curves.linear);
    }
  }

  Future<void> restartScrolling() async {
    await Future.delayed(const Duration(seconds: 2));
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    await Future.delayed(const Duration(seconds: 2));
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Perform your task
    }
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 10), curve: Curves.linear);
  }

  @override
  void initState() {
    // startScrolling();
    // If you want infinite scrolling use the following code
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     // Scroll has reached the end, reset the position to the beginning.
    //     startScrolling();
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<NurseBloc, NurseState>(
        listener: (context, state) async {
          if (state.blinkTokens.isNotEmpty) {
            //NurseTokens
            playSound();
          }
          startScrolling();
          return;
        },
        builder: (context, state) => Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                controller: scrollController,
                itemCount: state.tokens.length,
                itemBuilder: (BuildContext context, int index) {
                  if (state.blinkTokens.isNotEmpty &&
                      state.blinkTokens.containsKey(
                          state.data!.tokens![index].id.toString())) {
                    return NurseBlinkToken(tokens: state.data!.tokens![index]);
                  } else {
                    return SizedBox(
                      height: 40,
                      child: Row(children: [
                        const Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text('${state.data!.tokens![index].token}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstants.brownishGrey2)),
                        ),
                        const Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 4,
                          child: getStatus(state.data!.tokens![index]),
                        ),
                        const Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ]),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ));
  }

  Widget getStatus(Tokens tokens) {
    var status = tokens.calledFlag;
    if (status == 1) {
      return Text('${tokens.called}',
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstants.bottomHeader));
    } else if (status == 0) {
      return const Text('In Queue',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstants.brownishGrey2));
    } else {
      return const Text('',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstants.brownishGrey2));
    }
  }
}
