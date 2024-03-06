import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/token/view/token_blink.dart';

import '../../config/color_constants.dart';
import '../bloc/token_bloc.dart';
import '../bloc/token_state.dart';

class TokenItem extends StatefulWidget {
  const TokenItem({Key? key}) : super(key: key);

  @override
  State<TokenItem> createState() => _TokenItemState();
}

class _TokenItemState extends State<TokenItem>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  Future<void> startScrolling() async {
    await Future.delayed(const Duration(seconds: 2));
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    await Future.delayed(const Duration(seconds: 2));
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Perform your task
    } else {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 10), curve: Curves.linear);
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
    startScrolling();
    // If you want infinite scrolling use the following code
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Scroll has reached the end, reset the position to the beginning.
        startScrolling();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<TokenBloc, TokenState>(
        builder: (context, state) => Expanded(
          child: ListView.separated(
                shrinkWrap: true,
                controller: scrollController,
                padding: const EdgeInsets.all(0),
                itemCount: state.tokens.length,
                itemBuilder: (BuildContext context, int index) {
                  if (state.blinkTokens.contains(state.tokens[index].id)) {
                    return SizedBox(
                        height: 40,
                        child: BlinkToken(
                            index: index,
                            counter: '${state.tokens[index].counter}',
                            token: '${state.tokens[index].token}'));
                  } else {
                    return SizedBox(
                      height: 40,
                      child: Row(children: [
                        SizedBox(width: sWidth * 0.20),
                        SizedBox(
                          width: sWidth * .35,
                          child: Text('${state.tokens[index].counter}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: ColorConstants.brownishGrey2)),
                        ),
                        SizedBox(width: sWidth * 0.05),
                        SizedBox(
                            width: sWidth * .35,
                            child: Text('${state.tokens[index].token}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: ColorConstants.brownishGrey2))),
                        SizedBox(width: sWidth * 0.05),
                      ]),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
        ));
  }
}
