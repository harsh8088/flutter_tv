import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/nurse/view/nurse_body.dart';

import '../repository/my_requests_repository.dart';
import 'bloc/nurse_bloc.dart';
import 'bloc/nurse_event.dart';

class NurseScreen extends StatelessWidget {
  const NurseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => NurseBloc(
                  repository: MyRequestRepository(),
                )..add(const NurseFetchEvent()),
            child: NurseBody()));
  }
}
