class DataOrError<E extends Object> {
  E? data;
  ServerError? error;
  DataOrError({this.data, this.error});
}

class ServerError {
  String? get error => data['error'].toString();
  ServerError({
    required this.data,
  });
  Map<String, dynamic> data;
  factory ServerError.fromJson(Map<String, dynamic> json) =>
      ServerError(
        data: json,
      );
}
