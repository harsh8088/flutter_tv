class ApiResponse<T> {
  int? statusCode;
  T? data;
  String? message;

  ApiResponse({this.statusCode, this.data, this.message});

  // Response.loading(this.message) : status = Status.LOADING;
  //
  // Response.completed(this.data) : status = Status.COMPLETED;
  //
  // Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $statusCode \n Message : $message \n Data : $data";
  }
}

// enum Status { LOADING, COMPLETED, ERROR }
