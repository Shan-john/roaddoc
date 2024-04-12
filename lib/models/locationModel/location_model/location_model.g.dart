// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      message: json['Message'] as String?,
      status: json['Status'] as String?,
      postOffice: (json['PostOffice'] as List<dynamic>?)
          ?.map((e) => PostOffice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Status': instance.status,
      'PostOffice': instance.postOffice,
    };
