import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String? cityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;

  const City({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  /// Factory constructor for creating a City instance from a JSON map.
  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json['city_id'] as String?,
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
        type: json['type'] as String?,
        cityName: json['city_name'] as String?,
        postalCode: json['postal_code'] as String?,
      );

  /// Converts a City instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'city_id': cityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };

  @override
  List<Object?> get props => [
        cityId,
        provinceId,
        province,
        type,
        cityName,
        postalCode,
      ];

  @override
  String toString() {
    return 'City(cityId: $cityId, provinceId: $provinceId, province: $province, type: $type, cityName: $cityName, postalCode: $postalCode)';
  }

  /// Factory constructor for creating a compact City instance with minimal fields.
  factory City.compactFromJson(Map<String, dynamic> json) => City(
        cityId: json['city_id'] as String?,
        cityName: json['city_name'] as String?,
      );

  /// Converts a compact City instance to a JSON map.
  Map<String, dynamic> compactToJson() => {
        'city_id': cityId,
        'city_name': cityName,
      };

  /// Factory constructor for creating a City instance from either compact or detailed JSON.
  factory City.fromJsonCompactOrDetailed(Map<String, dynamic> json) => City(
        cityId: json['city_id'] as String?,
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
        type: json['type'] as String?,
        cityName: json['city_name'] as String?,
        postalCode: json['postal_code'] as String?,
      );
}