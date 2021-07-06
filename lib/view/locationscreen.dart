// @dart=2.9

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/controller/weather_controller.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/models/weather_brain.dart';
import 'package:weather/utilities/constant.dart';

import 'city_secreen.dart';

class LocationSecreen extends StatefulWidget {
  LocationSecreen({Key key}) : super(key: key);

  @override
  _LocationSecreenState createState() => _LocationSecreenState();
}

class _LocationSecreenState extends State<LocationSecreen> {
  WeatherController weatherController;
  WeatherModel weatherModel;
  WeatherApi weather;
  // ignore: unused_field
  bool _isLoadingForLocation;
  bool _isLoadingWeather;

  @override
  void initState() {
    super.initState();
    _isLoadingForLocation = true;
    _isLoadingWeather = true;

    weatherController = WeatherController();
    weatherModel = WeatherModel();
    getLocatiion();
  }

  void getWeatherByCityName(String name) async {
    try {
      var weather = await weatherController.getWeatherByCityName(name);

      setState(() {
        weather = weather;
        _isLoadingWeather = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingWeather = false;
      });
    }
  }

  void getWeatherBylatlon(double lat, double lon) async {
    try {
      var weather = await weatherController.getWeatherByLatLong(lat, lon);

      setState(() {
        weather = weather;
        _isLoadingWeather = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingWeather = false;
      });
    }
  }

  void getLocatiion() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _isLoadingForLocation = false;
      });

      if (position.latitude != null && position.longitude != null) {
        getWeatherBylatlon(position.latitude, position.longitude);
      }
      print(position.latitude);
      print(position.longitude);
    } catch (e) {
      setState(() {
        _isLoadingForLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingWeather == false &&
              _isLoadingForLocation == false &&
              weather != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets\images\location_background.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLoadingForLocation = true;
                              _isLoadingWeather = true;
                            });
                            getLocatiion();
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            String cityName = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CityScreen();
                            }));
                            if (cityName != null) {
                              setState(() {
                                _isLoadingWeather = true;
                              });
                              getWeatherByCityName(cityName);
                            }
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.main.temp.round().toString(),
                            textAlign: TextAlign.center,
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherModel.getWeatherIcon(weather.weather[0].id),
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        weatherModel.getMessage(weather.main.temp.round()) +
                            '\n  ${weather.name}',
                        textAlign: TextAlign.center,
                        style: kMessageTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
    );
  }
}
