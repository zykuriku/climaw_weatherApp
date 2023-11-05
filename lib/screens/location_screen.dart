import 'package:climaw/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climaw/utilities/constants.dart';

var typedName = "";

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);
  final locationWeather;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp = 0;
  int condition = 0;
  String city = "";
  String icon = "";
  int humidity = 0;
  String desc = "";
  int feelsLike = 0;
  int visibility = 0;

  @override
  void initState() {
    super.initState();
    update(widget.locationWeather);
  }

  void update(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        icon = "error";
        condition = 0;
        city = "";
        return;
      }
      city = weatherData['name'];
      double t = weatherData['main']['temp'];
      temp = t.toInt();
      condition = weatherData['weather'][0]['id'];
      icon = weatherData['weather'][0]['icon'];
      humidity = weatherData['main']['humidity'];
      visibility = weatherData['visibility'];
      desc = weatherData['weather'][0]['description'];
      double fl = weatherData['main']['feels_like'];
      feelsLike = fl.toInt();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bgog.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.6), BlendMode.dstATop))),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 150.0,
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) {
                        typedName = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter city name",

                        hintStyle: TextStyle(color: Colors.grey),
                        // prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      if (typedName != null) {
                        WeatherModel weather = new WeatherModel();
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        update(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
              ],
            ),
            SizedBox(
                // height: 60.0,
                ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      temp.toString() + '\u00b0',
                      style: kTemperatureStyle,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://openweathermap.org/img/wn/$icon@2x.png'),
                          height: 50.0,
                          width: 50.0,
                        ),
                        Text(
                          desc,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 120.0,
                    height: 1.0,
                    child: ColoredBox(color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        update(widget.locationWeather);
                      },
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      city,
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Feels like " + feelsLike.toString() + '\u00b0',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Humidity: " + humidity.toString() + '%'),
                      Text("Visibility: " + visibility.toString() + "m"),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(),
          ],
        )),
      ),
    );
  }
}
