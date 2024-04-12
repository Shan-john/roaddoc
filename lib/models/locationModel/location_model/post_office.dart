import 'package:json_annotation/json_annotation.dart';

part 'post_office.g.dart';

@JsonSerializable()
class PostOffice {
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'Description')
  dynamic description;
  @JsonKey(name: 'BranchType')
  String? branchType;
  @JsonKey(name: 'DeliveryStatus')
  String? deliveryStatus;
  @JsonKey(name: 'Circle')
  String? circle;
  @JsonKey(name: 'District')
  String? district;
  @JsonKey(name: 'Division')
  String? division;
  @JsonKey(name: 'Region')
  String? region;
  @JsonKey(name: 'Block')
  String? block;
  @JsonKey(name: 'State')
  String? state;
  @JsonKey(name: 'Country')
  String? country;
  @JsonKey(name: 'Pincode')
  String? pincode;

  PostOffice({
    this.name,
    this.description,
    this.branchType,
    this.deliveryStatus,
    this.circle,
    this.district,
    this.division,
    this.region,
    this.block,
    this.state,
    this.country,
    this.pincode,
  });

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return _$PostOfficeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostOfficeToJson(this);

  PostOffice copyWith({
    String? name,
    dynamic description,
    String? branchType,
    String? deliveryStatus,
    String? circle,
    String? district,
    String? division,
    String? region,
    String? block,
    String? state,
    String? country,
    String? pincode,
  }) {
    return PostOffice(
      name: name ?? this.name,
      description: description ?? this.description,
      branchType: branchType ?? this.branchType,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      circle: circle ?? this.circle,
      district: district ?? this.district,
      division: division ?? this.division,
      region: region ?? this.region,
      block: block ?? this.block,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
    );
  }
}
