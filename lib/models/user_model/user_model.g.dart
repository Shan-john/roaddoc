// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      mailid: json['mailid'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as int?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      type: json['type'] as String?,
      dateAndTime: json['dateAndTime'] as String?,
      inspectionCategory: json['inspectionCategory'] as String?,
      inspectionmessage: json['inspectionmessage'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'mailid': instance.mailid,
      'phoneNumber': instance.phoneNumber,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'type': instance.type,
      'dateAndTime': instance.dateAndTime,
      'inspectionCategory': instance.inspectionCategory,
      'inspectionmessage': instance.inspectionmessage,
    };
