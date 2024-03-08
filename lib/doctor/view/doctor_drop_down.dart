import 'package:flutter/material.dart';
import 'package:flutter_tv/config/session_manager.dart';

class DoctorDropDown extends StatefulWidget {
  const DoctorDropDown({super.key});

  @override
  State<DoctorDropDown> createState() => _DoctorDropDownState();
}

class _DoctorDropDownState extends State<DoctorDropDown> {
  static const List<String> list = <String>[
    ' Single Doctor',
    ' Three Doctors',
    ' Multiple Doctors'
  ];

  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDoctorType(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future hasn't finished yet, return a placeholder
            return const Text('Loading');
          } else {
            return DropdownButton<String>(
              // value: snapshot.data,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 8,
              onChanged: (String? value) async {
                // This is called when the user selects an item.
                if (snapshot.data != value) {
                  SessionManager().setDoctorScreenType(value!);
                  switch (value) {
                    case ' Single Doctor':
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/doctor", (Route route) => false);
                      return;
                    case ' Three Doctors':
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/three-doctors", (Route route) => false);
                      return;
                    case ' Multiple Doctors':
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/multiple-doctors", (Route route) => false);
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
            );
          }
        });
  }

  Future<dynamic> fetchDoctorType() async {
    return await SessionManager().getDoctorScreenType();
  }
}
