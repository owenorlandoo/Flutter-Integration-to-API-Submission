part of 'model.dart';

class Province extends Equatable {
  final String? provinceId;
  final String? province;

  const Province({
    this.provinceId,
    this.province,
  });

  /// Factory constructor for creating a Province instance from a JSON map.
  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
      );

  /// Converts a Province instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'province_id': provinceId,
        'province': province,
      };

  @override
  List<Object?> get props => [provinceId, province];

  @override
  String toString() {
    return 'Province(provinceId: $provinceId, province: $province)';
  }
}