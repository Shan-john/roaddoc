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
  String? date;
  String? inspectionCategory;
  String? inspectionmessage;
  String? image;
  String? address;
  String? amount;
  String? paymentmethod;
  String? time;

  UserModel(
      {this.mailid,
      this.name,
      this.id,
      this.phoneNumber,
      this.longitude,
      this.latitude,
      this.type,
      this.date,
      this.inspectionCategory,
      this.inspectionmessage,
      this.image,
      this.address,
      this.amount,
      this.time,
      this.paymentmethod});

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
    String? date,
    String? inspectionCategory,
    String? inspectionmessage,
    String? image,
    String? address,
    String? amount,
    String? paymentmethod,
      String? time,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      mailid: mailid ?? this.mailid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      type: type ?? this.type,
      date: date ?? this.date,
      inspectionCategory: inspectionCategory ?? this.inspectionCategory,
      inspectionmessage: inspectionmessage ?? this.inspectionmessage,
      image: image ?? this.image,
      address: address ?? this.address,
      amount: amount ?? this.amount,
      paymentmethod: paymentmethod ?? this.paymentmethod,
      time: time??this.time,
    );
  }
}
