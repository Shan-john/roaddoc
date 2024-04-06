import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? id;
  String? mailid;
  int? phoneNumber;
  double? longitude;
  double? latitude;
  String? type;
  String? dateAndTime;
  String? ismechreached;
  String? inspectionmessage;

  UserModel({
    this.mailid,
    this.name,
    this.id,
    this.phoneNumber,
    this.longitude,
    this.latitude,
    this.type,
    this.dateAndTime,
    this.ismechreached,
    this.inspectionmessage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? mailid,
    String? name,
    String? id,
    int? phoneNumber,
    double? longitude,
    double? latitude,
    String? type,
    String? dateAndTime,
    String? ismechreached,
    String? inspectionmessage,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      mailid: mailid ?? this.mailid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      type: type ?? this.type,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      ismechreached: ismechreached ?? this.ismechreached,
      inspectionmessage: inspectionmessage ?? this.inspectionmessage,
    );
  }
}
