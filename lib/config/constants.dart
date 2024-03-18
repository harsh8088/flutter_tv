/// Declare all the app constants here
class Constants {
  static String appName = "FlutterTV";
  static String appVersion = "v0.0.1";
  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  /// ----DEV ENV Start---->

  static String headerKey = "";
  static String baseUrl =
      "https://sandboxapiportal.mhea.myhealthcare.co/api/qms/android/v1/";
  static String baseUrlDoctor =
      "https://sandboxtestipdapi.mhea.myhealthcare.co/api/opdemr/agent-portal/";
  static String displayTv = '${baseUrl}display-tv';
  static String displayServices = '${baseUrl}display-services';
  static String practiceStatus = '${baseUrlDoctor}practice-status';
  static String soundUrl =
      "https://dev.appapis.desktop.myhealthcare.co/qms/default_audio.mp3";
  static String emrAuth="OzxOcSjaMtXpuqEGJhsPDx8UDW8Is0v6oQKqyTobaaouoTYWYgzsExc7h8EzYZva";

  /// <----DEV ENV End------

  static String userId = 'userId';
  static String mobileNumber = 'number';
  static String authToken = 'authToken';
  static String userName = 'userName';
  static String userImage = 'userImage';
  static String fcmToken = 'fcmToken';

  static String unAuthorizedState = "UnAuthorized";

  // Login
  static String mByLogging = "By logging you agree, ";
  static String mtermsConditionUrl = "Terms and Conditions";
  static String termsConditionUrl = "";
  static String deviceID = "ID_9875";
  static String deviceModel = "Test_Device";

  static String mprivacyPolicy = "Privacy Policy";
  static String privacyPolicy = "";

  static String phone = "";

  static String keyCounters = "counters";
  static String keyTokens = "tokens";
}
