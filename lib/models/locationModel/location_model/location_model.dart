import 'package:json_annotation/json_annotation.dart';

import 'post_office.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'Status')
  String? status;
  @JsonKey(name: 'PostOffice')
  List<PostOffice>? postOffice;

  LocationModel({this.message, this.status, this.postOffice});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return _$LocationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  LocationModel copyWith({
    String? message,
    String? status,
    List<PostOffice>? postOffice,
  }) {
    return LocationModel(
      message: message ?? this.message,
      status: status ?? this.status,
      postOffice: postOffice ?? this.postOffice,
    );
  }
}
