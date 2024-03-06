import 'package:intl/intl.dart';

class AppUtils {
  //gender 1:F, 2:M
  static String getGender(int? gender) {
    switch (gender) {
      case 1:
        return "F";
      case 2:
        return "M";
      default:
        return "";
    }
  }

  //input: yyyy-MM-dd , output: dd-MM-yyyy
  static String? getDate(String? dateString) {
    try {
      var inputFormat = DateFormat('yyyy-MM-dd');
      var date1 = inputFormat.parse('$dateString');
      var outputFormat = DateFormat('dd-MM-yyyy');
      // var date2 = outputFormat.format(date1); // 2019-08-18
      return outputFormat.format(date1);
    } catch (_) {
      print(_.toString());
      return dateString;
    }
  }

  //input: yyyy-MM-dd , output: dd MMM yyyy
  static String? getDateWorklist(String? dateString) {
    try {
      var inputFormat = DateFormat('yyyy-MM-dd');
      var date1 = inputFormat.parse('$dateString');
      var outputFormat = DateFormat('dd MMM yyyy');
      // var date2 = outputFormat.format(date1); // 2019-08-18
      return outputFormat.format(date1);
    } catch (_) {
      print(_.toString());
      return dateString;
    }
  }

  // output: dd MMM yyyy
  static String? getCurrentTime() {
    try {
      return DateFormat('E, h:mm a').format(DateTime.now());
    } catch (_) {
      print(_.toString());
      return "";
    }
  }

  //input: 09:00:00 HH:mm:ss
  static String? getDoctorTimeDate(String? dateString) {
    try {
      var inputFormat = DateFormat('HH:mm:ss');
      var date1 = inputFormat.parse('$dateString');
      var outputFormat = DateFormat('h:mm a');
      return outputFormat.format(date1);
    } catch (_) {
      print(_.toString());
      return dateString;
    }
  }

  static String getRouteName(int? displayType) {
    switch (displayType) {
      case 2:
        return '/doctor';
      case 3:
        return '/token';
      case 4:
        return '/nurse';
      default:
        return '/token';
    }
  }
}
