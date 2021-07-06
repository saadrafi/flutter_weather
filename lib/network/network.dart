import 'package:weather/constans/api/api.dart';
import 'package:weather/constans/const.dart';

class NetworkCall {
  Future<String> loadWeather(String name) async {
    String apiName = ApiConstants.GET_WEATHER +
        '/weather?q=$name&appid=${ApiConstants.API_KEY}&units=metric';
    var api = Uri.parse(apiName);

    var response = await client.get(api);
    return response.body;
  }

  Future<String> loadWeatherByLatLon(double lat, double lon) async {
    String apiName = ApiConstants.GET_WEATHER +
        '/weather?lat=$lat&lon=$lon&appid=${ApiConstants.API_KEY}&units=metric';
    var api = Uri.parse(apiName);
    var response = await client.get(api);
    return response.body;
  }
}
