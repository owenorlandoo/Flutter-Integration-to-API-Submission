import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/model/model.dart';
import 'package:mvvm/model/city.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  // Fetch provinces
  Future<List<Province>> fetchProvinceList() async {
    try {
      final response = await _apiServices.getApiResponse('/starter/province');
      return (response['rajaongkir']['results'] as List)
          .map((e) => Province.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch provinces: $e");
    }
  }

  // Fetch cities by province ID
  Future<List<City>> fetchCityList(String provinceId) async {
    try {
      final response = await _apiServices.getApiResponse('/starter/city?province=$provinceId');
      return (response['rajaongkir']['results'] as List)
          .map((e) => City.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch cities: $e");
    }
  }
}
