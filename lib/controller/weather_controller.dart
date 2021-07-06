// @dart=2.9
import 'dart:convert';

import 'package:weather/constans/const.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/network/network.dart';

class WeatherController {
  Future<WeatherApi> getWeatherByCityName(String name) async {
    var response = await networkCall.loadWeather(name);
    return WeatherApi.fromJson(jsonDecode(response));
  }

  Future<WeatherApi> getWeatherByLatLong(double lat, double lon) async {
    var response = await networkCall.loadWeatherByLatLon(lat, lon);
    return WeatherApi.fromJson(jsonDecode(response));
  }
}
