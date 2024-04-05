class PracticeResponse {
  bool? status;
  String? message;
  String? isPracticing;

  PracticeResponse({this.status, this.message, this.isPracticing});

  PracticeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isPracticing = json['is_practicing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['is_practicing'] = isPracticing;
    return data;
  }
}
