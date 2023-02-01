import 'package:intl/intl.dart';

class AppUtils {
  //gender 1:F, 2:M
  static String getGender(int? gender) {
    if (gender == 1)
      return "F";
    else if (gender == 2) return "M";
    return "";
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
}
