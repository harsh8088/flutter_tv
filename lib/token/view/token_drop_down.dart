import 'package:flutter/material.dart';
import 'package:flutter_tv/config/session_manager.dart';

class TokenDropDown extends StatefulWidget {
  const TokenDropDown({super.key});

  @override
  State<TokenDropDown> createState() => _TokenDropDownState();
}

class _TokenDropDownState extends State<TokenDropDown> {
  static const List<String> list = <String>[
    ' Called Tokens',
    ' All Tokens',
  ];

  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchTokenType(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future hasn't finished yet, return a placeholder
            return const Text('Loading');
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: DropdownButton<String>(
                value: snapshot.data,
                underline: Container(
                  height: 1,
                  color: Colors.transparent,
                ),
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 8,
                onChanged: (String? value) async {
                  // This is called when the user selects an item.
                  if (snapshot.data != value) {
                    SessionManager().setTokenScreenType(value!);
                    switch (value) {
                      case ' Called Tokens':
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/token", (Route route) => false);
                        return;
                      case ' All Tokens':
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/all-tokens", (Route route) => false);
                        return;
                    }
                  }
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          }
        });
  }

  Future<dynamic> fetchTokenType() async {
    return await SessionManager().getTokenScreenType();
  }
}
