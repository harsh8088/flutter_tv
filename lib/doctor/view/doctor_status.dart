import 'dart:math';

import 'package:flutter/material.dart';

class DoctorStatusWidget extends StatelessWidget {
  const DoctorStatusWidget(
      {super.key, required this.hospitalId, required this.doctorId});

  final int doctorId;
  final int hospitalId;

  @override
  Widget build(BuildContext context) {
    print("DoctorStatusWidget");
    print(MediaQuery.of(context).size.width);
    print("hospitalId: $hospitalId ,doctorId:$doctorId");
    return FutureBuilder(
        initialData: "OUT",
        future: fetchPracticeStatus(),
        builder: (context, snapshot) {
          return Flexible(
            child: Container(
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Text("${snapshot.data}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: "${snapshot.data}" == "IN"
                              ? Colors.green
                              : Colors.redAccent)),
                ),
              ),
            ),
          );
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future hasn't finished yet, return a placeholder

            return Flexible(
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
              ),
            );
          } else {
            return Flexible(
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text("${snapshot.data}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: "${snapshot.data}" == "IN"
                                ? Colors.green
                                : Colors.redAccent)),
                  ),
                ),
              ),
            );
          }
        });
  }

  Future<dynamic> fetchPracticeStatus() async {
    var list = ['Y', 'N'];
    list.elementAt(Random().nextInt(list.length));
    var map = {
      'status': true,
      'message': '',
      'is_practicing': list.elementAt(Random().nextInt(list.length))
    };

    var result = map["is_practicing"];

    // await MyRequestRepository()
    //     .getPracticeStatus(hospitalId: hospitalId, doctorId: doctorId);
    // await Future.delayed(const Duration(seconds: 2));

    return result == 'Y' ? "IN" : "OUT";
  }
}

// class DoctorStatusWidget extends StatefulWidget {
//   const DoctorStatusWidget(
//       {super.key, required this.hospitalId, required this.doctorId});
//
//   final int doctorId;
//   final int hospitalId;
//
//   @override
//   State<DoctorStatusWidget> createState() => _DoctorStatusWidgetState();
// }
//
// class _DoctorStatusWidgetState extends State<DoctorStatusWidget> {
//   static const List<String> list = <String>[
//     ' Single Doctor',
//     ' Three Doctors',
//     ' Multiple Doctors'
//   ];
//
//   String dropdownValue = list.first;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("width");
//     print(MediaQuery.of(context).size.width);
//     print("updatedWidth");
//     print(MediaQuery.of(context).size.width * 0.33 * 2);
//     var sWidth = MediaQuery.of(context).size.width;
//     print("hospitalId: ${widget.hospitalId} ,doctorId:${widget.doctorId}");
//
//     return FutureBuilder(
//         future: fetchPracticeStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Future hasn't finished yet, return a placeholder
//             return Flexible(
//               child: Container(
//                 width: 70,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25)),
//               ),
//             );
//           } else {
//             return Flexible(
//               child: Container(
//                 width: 70,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25)),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
//                     child: Text("${snapshot.data}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: "${snapshot.data}" == "IN"
//                                 ? Colors.green
//                                 : Colors.redAccent)),
//                   ),
//                 ),
//               ),
//             );
//           }
//         });
//   }
//
//   Future<dynamic> fetchPracticeStatus() async {
//     print("fetchPracticeStatus");
//     var list = ['Y', 'N'];
//     list.elementAt(Random().nextInt(list.length));
//     var map = {
//       'status': true,
//       'message': '',
//       'is_practicing': list.elementAt(Random().nextInt(list.length))
//     };
//
//     var result = map["is_practicing"];
//
//     // await MyRequestRepository()
//     //     .getPracticeStatus(hospitalId: hospitalId, doctorId: doctorId);
//
//     return result == 'Y' ? "IN" : "OUT";
//   }
// }
