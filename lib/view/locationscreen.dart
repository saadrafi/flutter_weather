import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationSecreen extends StatefulWidget {
  LocationSecreen({Key? key}) : super(key: key);

  @override
  _LocationSecreenState createState() => _LocationSecreenState();
}

class _LocationSecreenState extends State<LocationSecreen> {
  // ignore: unused_field
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getLocatiion();
  }

  void getLocatiion() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _isLoading = false;
      });
      print(position.longitude);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading == false
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
                            setState(() {});
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {});
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
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(''),
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
