class NurseResponse {
  int? deviceType;
  String? scrollText;
  String? scrollTextEn;
  String? missedText;
  String? missedTextEn;
  List<Tokens>? tokens;
  List<CounterToDisplay>? counterToDisplay;
  Hospital? hospital;
  String? skipedTokens;

  NurseResponse(
      {this.deviceType,
      this.scrollText,
      this.scrollTextEn,
      this.missedText,
      this.missedTextEn,
      this.tokens,
      this.counterToDisplay,
      this.hospital,
      this.skipedTokens});

  NurseResponse.fromJson(Map<String, dynamic> json) {
    deviceType = json['device_type'];
    scrollText = json['scroll_text'];
    scrollTextEn = json['scroll_text_en'];
    missedText = json['missed_text'];
    missedTextEn = json['missed_text_en'];
    if (json['tokens'] != null) {
      tokens = <Tokens>[];
      json['tokens'].forEach((v) {
        tokens!.add(Tokens.fromJson(v));
      });
    }
    if (json['counter_to_display'] != null) {
      counterToDisplay = <CounterToDisplay>[];
      json['counter_to_display'].forEach((v) {
        counterToDisplay!.add(CounterToDisplay.fromJson(v));
      });
    }
    hospital =
        json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
    skipedTokens = json['skiped_tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_type'] = deviceType;
    data['scroll_text'] = scrollText;
    data['scroll_text_en'] = scrollTextEn;
    data['missed_text'] = missedText;
    data['missed_text_en'] = missedTextEn;
    if (tokens != null) {
      data['tokens'] = tokens!.map((v) => v.toJson()).toList();
    }
    if (counterToDisplay != null) {
      data['counter_to_display'] =
          counterToDisplay!.map((v) => v.toJson()).toList();
    }
    if (hospital != null) {
      data['hospital'] = hospital!.toJson();
    }
    data['skiped_tokens'] = skipedTokens;
    return data;
  }
}

class Tokens {
  int? id;
  String? token;
  String? serviceName;
  String? counter;
  String? called;
  int? calledFlag;
  int? calledTokenCount;
  String? patientName;
  String? uhid;

  Tokens(
      {this.id,
      this.token,
      this.serviceName,
      this.counter,
      this.called,
      this.calledFlag,
      this.calledTokenCount,
      this.patientName,
      this.uhid});

  Tokens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    serviceName = json['service_name'];
    counter = json['counter'];
    called = json['called'];
    calledFlag = json['called_flag'];
    calledTokenCount = json['called_token_count'];
    patientName = json['patient_name'];
    uhid = json['uhid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    data['service_name'] = serviceName;
    data['counter'] = counter;
    data['called'] = called;
    data['called_flag'] = calledFlag;
    data['called_token_count'] = calledTokenCount;
    data['patient_name'] = patientName;
    data['uhid'] = uhid;
    return data;
  }
}

class CounterToDisplay {
  String? counterName;
  int? counterId;

  CounterToDisplay({this.counterName, this.counterId});

  CounterToDisplay.fromJson(Map<String, dynamic> json) {
    counterName = json['counter_name'];
    counterId = json['counter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counter_name'] = counterName;
    data['counter_id'] = counterId;
    return data;
  }
}

class Hospital {
  String? name;
  int? id;
  String? address;
  String? hospitalLogo;
  Floor? floor;

  Hospital({this.name, this.id, this.address, this.hospitalLogo, this.floor});

  Hospital.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    address = json['address'];
    hospitalLogo = json['hospital_logo'];
    floor = json['floor'] != null ? Floor.fromJson(json['floor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['address'] = address;
    data['hospital_logo'] = hospitalLogo;
    if (floor != null) {
      data['floor'] = floor!.toJson();
    }
    return data;
  }
}

class Floor {
  String? name;
  int? id;

  Floor({this.name, this.id});

  Floor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
