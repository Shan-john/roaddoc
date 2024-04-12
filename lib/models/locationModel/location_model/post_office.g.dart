// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOffice _$PostOfficeFromJson(Map<String, dynamic> json) => PostOffice(
      name: json['Name'] as String?,
      description: json['Description'],
      branchType: json['BranchType'] as String?,
      deliveryStatus: json['DeliveryStatus'] as String?,
      circle: json['Circle'] as String?,
      district: json['District'] as String?,
      division: json['Division'] as String?,
      region: json['Region'] as String?,
      block: json['Block'] as String?,
      state: json['State'] as String?,
      country: json['Country'] as String?,
      pincode: json['Pincode'] as String?,
    );

Map<String, dynamic> _$PostOfficeToJson(PostOffice instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Description': instance.description,
      'BranchType': instance.branchType,
      'DeliveryStatus': instance.deliveryStatus,
      'Circle': instance.circle,
      'District': instance.district,
      'Division': instance.division,
      'Region': instance.region,
      'Block': instance.block,
      'State': instance.state,
      'Country': instance.country,
      'Pincode': instance.pincode,
    };
