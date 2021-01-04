class TimeSheetResponseModel {
  final String message;
  final String error;

  TimeSheetResponseModel({this.message, this.error});

  factory TimeSheetResponseModel.fromJson(Map<String, dynamic> json) {
    return TimeSheetResponseModel(
      message: json["message"] != null ? json["message"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class TimeSheetRequestModel {
  String latitude;
  String longitude;
  String time;
  String type;

  TimeSheetRequestModel({
    this.latitude,
    this.longitude,
    this.time,
    this.type,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'latitude': latitude.trim(),
      'longitude': longitude.trim(),
      'time': time.trim(),
      'type': type.trim()
    };

    return map;
  }
}