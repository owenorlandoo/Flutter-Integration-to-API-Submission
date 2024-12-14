import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/city.dart';
import 'package:mvvm/model/model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeVm with ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> cityList = ApiResponse.loading();

  Province? selectedOriginProvince;
  Province? selectedDestinationProvince;
  City? selectedOriginCity;
  City? selectedDestinationCity;

  List<City> originCities = [];
  List<City> destinationCities = [];

  // Getter for provinces
  List<Province> get provinces {
    return provinceList.data ?? [];
  }

  void setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  void setCityList(ApiResponse<List<City>> response, {required bool isOrigin}) {
    if (isOrigin) {
      originCities = response.data ?? [];
    } else {
      destinationCities = response.data ?? [];
    }
    notifyListeners();
  }

  Future<void> fetchProvinces() async {
    setProvinceList(ApiResponse.loading());
    try {
      final provinces = await _repository.fetchProvinceList();
      setProvinceList(ApiResponse.completed(provinces));
    } catch (e) {
      setProvinceList(ApiResponse.error(e.toString()));
    }
  }

  Future<void> fetchCities(String provinceId, {required bool isOrigin}) async {
    setCityList(ApiResponse.loading(), isOrigin: isOrigin);
    try {
      final cities = await _repository.fetchCityList(provinceId);
      setCityList(ApiResponse.completed(cities), isOrigin: isOrigin);
    } catch (e) {
      setCityList(ApiResponse.error(e.toString()), isOrigin: isOrigin);
    }
  }

  void setSelectedOriginProvince(Province? province) {
    selectedOriginProvince = province;
    selectedOriginCity = null;
    if (province != null) {
      fetchCities(province.provinceId!, isOrigin: true);
    }
    notifyListeners();
  }

  void setSelectedDestinationProvince(Province? province) {
    selectedDestinationProvince = province;
    selectedDestinationCity = null;
    if (province != null) {
      fetchCities(province.provinceId!, isOrigin: false);
    }
    notifyListeners();
  }

  void setSelectedOriginCity(City? city) {
    selectedOriginCity = city;
    notifyListeners();
  }

  void setSelectedDestinationCity(City? city) {
    selectedDestinationCity = city;
    notifyListeners();
  }
}
