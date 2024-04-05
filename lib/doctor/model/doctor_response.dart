class DoctorResponse {
  int? deviceType;
  String? scrollText;
  String? scrollTextEn;
  String? missedText;
  String? missedTextEn;
  List<Doctors>? doctors;
  Hospital? hospital;

  DoctorResponse(
      {this.deviceType,
      this.scrollText,
      this.scrollTextEn,
      this.missedText,
      this.missedTextEn,
      this.doctors,
      this.hospital});

  DoctorResponse copyWith({
    int? deviceType,
    String? scrollText,
    String? scrollTextEn,
    String? missedText,
    String? missedTextEn,
    List<Doctors>? doctors,
    Hospital? hospital,
  }) {
    return DoctorResponse(
      deviceType: deviceType ?? this.deviceType,
      scrollText: scrollText ?? this.scrollText,
      scrollTextEn: scrollTextEn ?? this.scrollTextEn,
      missedText: missedText ?? this.missedText,
      missedTextEn: missedTextEn ?? this.missedTextEn,
      doctors: doctors ?? this.doctors,
      hospital: hospital ?? this.hospital,
    );
  }

  DoctorResponse.fromJson(Map<String, dynamic> json) {
    deviceType = json['device_type'];
    scrollText = json['scroll_text'];
    scrollTextEn = json['scroll_text_en'];
    missedText = json['missed_text'];
    missedTextEn = json['missed_text_en'];
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
    hospital =
        json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_type'] = deviceType;
    data['scroll_text'] = scrollText;
    data['scroll_text_en'] = scrollTextEn;
    data['missed_text'] = missedText;
    data['missed_text_en'] = missedTextEn;
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    if (hospital != null) {
      data['hospital'] = hospital!.toJson();
    }
    return data;
  }
}

class Doctors {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? myhealthcareEmail;
  String? myhealthcareMobile;
  int? myhealthcareGid;
  String? alternativeEmailAddress;
  int? gender;
  String? dob;
  String? profilePicture;
  String? address;
  String? officeNumber;
  String? qualification;
  String? experience;
  String? startedWorkingFrom;
  String? certification;
  List<String>? specialities;
  String? experianceDetails;
  String? awards;
  String? membership;
  String? researchPublications;
  String? blog;
  String? quora;
  String? testimonials;
  String? doctorBriefProfile;
  List<Tokens>? tokens;
  Room? room;
  WorkingTime? workingTime;
  List<Tokens>? queueTokens;

  Doctors(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.myhealthcareEmail,
      this.myhealthcareMobile,
      this.myhealthcareGid,
      this.alternativeEmailAddress,
      this.gender,
      this.dob,
      this.profilePicture,
      this.address,
      this.officeNumber,
      this.qualification,
      this.experience,
      this.startedWorkingFrom,
      this.certification,
      this.specialities,
      this.experianceDetails,
      this.awards,
      this.membership,
      this.researchPublications,
      this.blog,
      this.quora,
      this.testimonials,
      this.doctorBriefProfile,
      this.tokens,
      this.room,
      this.workingTime,
      this.queueTokens});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    myhealthcareEmail = json['myhealthcare_email'];
    myhealthcareMobile = json['myhealthcare_mobile'];
    myhealthcareGid = json['myhealthcare_gid'];
    alternativeEmailAddress = json['alternative_email_address'];
    gender = json['gender'];
    dob = json['dob'];
    profilePicture = json['profile_picture'];
    address = json['address'];
    officeNumber = json['office_number'];
    qualification = json['qualification'];
    experience = json['experience'];
    startedWorkingFrom = json['started_working_from'];
    certification = json['certification'];
    specialities = json['specialities'].cast<String>();
    experianceDetails = json['experiance_details'];
    awards = json['awards'];
    membership = json['membership'];
    researchPublications = json['research_publications'];
    blog = json['blog'];
    quora = json['quora'];
    testimonials = json['testimonials'];
    doctorBriefProfile = json['doctor_brief_profile'];
    if (json['tokens'] != null) {
      tokens = <Tokens>[];
      json['tokens'].forEach((v) {
        tokens!.add(Tokens.fromJson(v));
      });
    }
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    workingTime = json['working_time'] != null
        ? WorkingTime.fromJson(json['working_time'])
        : null;
    if (json['queueTokens'] != null) {
      queueTokens = <Tokens>[];
      json['queueTokens'].forEach((v) {
        queueTokens!.add(Tokens.fromJson(v));
      });
    }
  }

  Doctors copyWith(
      {int? id,
      String? firstName,
      String? middleName,
      String? lastName,
      String? myhealthcareEmail,
      String? myhealthcareMobile,
      int? myhealthcareGid,
      String? alternativeEmailAddress,
      int? gender,
      String? dob,
      String? profilePicture,
      String? address,
      String? officeNumber,
      String? qualification,
      String? experience,
      String? startedWorkingFrom,
      String? certification,
      List<String>? specialities,
      String? experianceDetails,
      String? awards,
      String? membership,
      String? researchPublications,
      String? blog,
      String? quora,
      String? testimonials,
      String? doctorBriefProfile,
      List<Tokens>? tokens,
      Room? room,
      WorkingTime? workingTime,
      List<Tokens>? queueTokens}) {
    return Doctors(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName:middleName??this.middleName,
        lastName:lastName??this.lastName,
        myhealthcareEmail:myhealthcareEmail??this.myhealthcareEmail,
        myhealthcareMobile:myhealthcareMobile??this.myhealthcareMobile,
        myhealthcareGid:myhealthcareGid??this.myhealthcareGid,
        alternativeEmailAddress:alternativeEmailAddress??this.alternativeEmailAddress,
        gender:gender??this.gender,
        dob:dob??this.dob,
        profilePicture:profilePicture??this.profilePicture,
        address:address??this.address,
        officeNumber:officeNumber??this.officeNumber,
        qualification:qualification??this.qualification,
        experience:experience??this.experience,
        startedWorkingFrom:startedWorkingFrom??this.startedWorkingFrom,
        certification:certification??this.certification,
        specialities:specialities??this.specialities,
        experianceDetails:experianceDetails??this.experianceDetails,
        awards:awards??this.awards,
        membership:membership??this.membership,
        researchPublications:researchPublications??this.researchPublications,
        blog:blog??this.blog,
        quora:quora??this.quora,
        testimonials:testimonials??this.testimonials,
        doctorBriefProfile:doctorBriefProfile??this.doctorBriefProfile,
        tokens:tokens??this.tokens,
        room:room??this.room,
        workingTime:workingTime??this.workingTime,
        queueTokens: queueTokens ?? this.queueTokens);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['myhealthcare_email'] = myhealthcareEmail;
    data['myhealthcare_mobile'] = myhealthcareMobile;
    data['myhealthcare_gid'] = myhealthcareGid;
    data['alternative_email_address'] = alternativeEmailAddress;
    data['gender'] = gender;
    data['dob'] = dob;
    data['profile_picture'] = profilePicture;
    data['address'] = address;
    data['office_number'] = officeNumber;
    data['qualification'] = qualification;
    data['experience'] = experience;
    data['started_working_from'] = startedWorkingFrom;
    data['certification'] = certification;
    data['specialities'] = specialities;
    data['experiance_details'] = experianceDetails;
    data['awards'] = awards;
    data['membership'] = membership;
    data['research_publications'] = researchPublications;
    data['blog'] = blog;
    data['quora'] = quora;
    data['testimonials'] = testimonials;
    data['doctor_brief_profile'] = doctorBriefProfile;
    if (tokens != null) {
      data['tokens'] = tokens!.map((v) => v.toJson()).toList();
    }
    if (room != null) {
      data['room'] = room!.toJson();
    }
    if (workingTime != null) {
      data['working_time'] = workingTime!.toJson();
    }
    if (queueTokens != null) {
      data['queueTokens'] = queueTokens!.map((v) => v.toJson()).toList();
    }
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

class Room {
  int? id;
  String? name;

  Room({this.id, this.name});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class WorkingTime {
  String? startTime;
  String? endTime;

  WorkingTime({this.startTime, this.endTime});

  WorkingTime.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}

class Hospital {
  String? name;
  int? id;
  String? address;
  String? hospitalLogo;
  Room? floor;

  Hospital({this.name, this.id, this.address, this.hospitalLogo, this.floor});

  Hospital.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    address = json['address'];
    hospitalLogo = json['hospital_logo'];
    floor = json['floor'] != null ? Room.fromJson(json['floor']) : null;
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
