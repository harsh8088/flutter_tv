class OtpResponse {
  bool? status;
  int? otp;

  OtpResponse({this.status, this.otp});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['otp'] = otp;
    return data;
  }
}
