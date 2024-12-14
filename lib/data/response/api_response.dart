// import 'package:mvvm/data/response/status.dart';

// class ApiResponse<T> {
//   Status? status;
//   T? data;
//   String? message;

//   ApiResponse(this.status, this.data, this.message);
//   ApiResponse.notstarted() : status = Status.notStarted;
//   ApiResponse.loading() : status = Status.loading;
//   ApiResponse.completed(this.data) : status = Status.completed;
//   ApiResponse.error(this.message) : status = Status.error;

//   @override
//   String toString() {
//     // TODO: implement ==
//     return "Status : $status \nMessage: $message \nData: $data";
//   }
// }
import 'package:mvvm/data/response/status.dart';

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  /// Constructor for the 'notStarted' state
  ApiResponse.notStarted() : status = Status.notStarted, data = null, message = null;

  /// Constructor for the 'loading' state
  ApiResponse.loading() : status = Status.loading, data = null, message = null;

  /// Constructor for the 'completed' state
  ApiResponse.completed(this.data) : status = Status.completed, message = null;

  /// Constructor for the 'error' state
  ApiResponse.error(this.message) : status = Status.error, data = null;

  @override
  String toString() {
    return "Status: $status \nMessage: $message \nData: $data";
  }
}
