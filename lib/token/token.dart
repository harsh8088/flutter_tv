import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/token/bloc/token_event.dart';
import 'package:flutter_tv/token/view/token_body.dart';

import '../repository/my_requests_repository.dart';
import 'bloc/token_bloc.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => TokenBloc(
                  repository: MyRequestRepository(),
                )..add(const TokenFetchEvent()),
            child: const TokenBody()));
  }
}
