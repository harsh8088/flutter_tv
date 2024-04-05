class TokenBlinkData {
  bool? blinkToken;
  String? progressToken;
  String? progressPatientName;

  TokenBlinkData(
      {this.blinkToken, this.progressToken, this.progressPatientName});

  TokenBlinkData.fromJson(Map<String, dynamic> json) {
    blinkToken = json['blinkToken'];
    progressToken = json['progressToken'];
    progressPatientName = json['progressPatientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['blinkToken'] = blinkToken;
    data['progressToken'] = progressToken;
    data['progressPatientName'] = progressPatientName;
    return data;
  }
}
