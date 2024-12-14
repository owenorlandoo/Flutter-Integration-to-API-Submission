import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/model/city.dart';
import 'package:mvvm/model/model.dart';

class ShippingRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      final response = await _apiServices.getApiResponse("province");
      if (response['rajaongkir']['status']['code'] == 200) {
        return (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to fetch provinces");
      }
    } catch (e) {
      throw Exception("Error fetching provinces: $e");
    }
  }

  Future<List<City>> fetchCityList(String provinceId) async {
    try {
      final response = await _apiServices.getApiResponse("city?province=$provinceId");
      if (response['rajaongkir']['status']['code'] == 200) {
        return (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to fetch cities");
      }
    } catch (e) {
      throw Exception("Error fetching cities: $e");
    }
  }


  /// Fetch shipping costs
  Future<List<dynamic>> fetchShippingCosts({
  required String originCity,
  required String destinationCity,
  required int weight,
  required String courier,
}) async {
  try {
    final response = await _apiServices.postApiResponse(
      'cost', // Correct endpoint
      {
        "origin": originCity,
        "destination": destinationCity,
        "weight": weight.toString(),
        "courier": courier,
      },
    );
    if (response['rajaongkir']['status']['code'] == 200) {
      final results = response['rajaongkir']['results'] as List;
      return results
          .expand((result) => (result['costs'] as List<dynamic>))
          .toList();
    } else {
      throw Exception(
          "Failed to fetch shipping costs: ${response['rajaongkir']['status']['description']}");
    }
  } catch (e) {
    throw Exception("Error fetching shipping costs: $e");
  }
}
}
