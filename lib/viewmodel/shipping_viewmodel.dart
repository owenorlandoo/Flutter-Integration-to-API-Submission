import 'package:flutter/material.dart';
import 'package:mvvm/model/city.dart';
import 'package:mvvm/repository/shipping_repository.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/model.dart';

class ShippingViewModel with ChangeNotifier {
  final ShippingRepository _repository = ShippingRepository();

ApiResponse<List<Province>> provinces = ApiResponse.notStarted();
  ApiResponse<List<City>> originCities = ApiResponse.notStarted();
  ApiResponse<List<City>> destinationCities = ApiResponse.notStarted();
  ApiResponse<List<dynamic>> costs = ApiResponse.notStarted();
  
    Future<void> fetchProvinces() async {
    provinces = ApiResponse.loading();
    notifyListeners();
    try {
      final response = await _repository.fetchProvinceList();
      provinces = ApiResponse.completed(response);
    } catch (e) {
      provinces = ApiResponse.error(e.toString());
    } finally {
      notifyListeners();
    }
  }

  // Fetch cities for origin province
  Future<void> fetchOriginCities(String provinceId) async {
    originCities = ApiResponse.loading();
    notifyListeners();
    try {
      final response = await _repository.fetchCityList(provinceId);
      originCities = ApiResponse.completed(response);
    } catch (e) {
      originCities = ApiResponse.error("Failed to fetch origin cities: $e");
    } finally {
      notifyListeners();
    }
  }

  /// Fetch cities for destination province
  Future<void> fetchDestinationCities(String provinceId) async {
    destinationCities = ApiResponse.loading();
    notifyListeners();
    try {
      final response = await _repository.fetchCityList(provinceId);
      destinationCities = ApiResponse.completed(response);
    } catch (e) {
      destinationCities = ApiResponse.error("Failed to fetch destination cities: $e");
    } finally {
      notifyListeners();
    }
  }

  /// Calculate shipping cost
  Future<void> calculateShippingCost({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) async {
    costs = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await _repository.fetchShippingCosts(
        originCity: origin,
        destinationCity: destination,
        weight: weight,
        courier: courier,
      );
      costs = ApiResponse.completed(response);
      print("Shipping costs fetched: $response");
    } catch (e) {
      costs = ApiResponse.error("Failed to calculate shipping cost: $e");
      print("Error fetching shipping costs: $e");
    } finally {
      notifyListeners();
    }
  }
}
