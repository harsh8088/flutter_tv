abstract class DoctorEvent {
  const DoctorEvent();
}

class DoctorFetchEvent extends DoctorEvent {
  const DoctorFetchEvent();
}

class DoctorPracticeFetchEvent extends DoctorEvent {
  const DoctorPracticeFetchEvent(this.doctorId, this.hospitalId);

  final int doctorId;
  final int hospitalId;
}

class DoctorThreeFetchEvent extends DoctorEvent {
  const DoctorThreeFetchEvent();
}

class DoctorMultipleFetchEvent extends DoctorEvent {
  const DoctorMultipleFetchEvent();
}
