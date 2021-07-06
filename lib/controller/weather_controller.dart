// @dart=2.9
import 'dart:convert';

import 'package:weather/constans/const.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/network/network.dart';

class WeatherController {
  Future<WeatherAPi> getWeatherByCityName(String name) async {
    var response = await networkCall.loadWeather(name);
    return WeatherAPi.fromJson(jsonDecode(response));
  }

   Future<WeatherAPi> getWeatherByLatLong(double lat, double lon) async {
    var response = await networkCall.loadWeatherByLatLon(lat,lon);
    return WeatherAPi.fromJson(jsonDecode(response));
  }

}
