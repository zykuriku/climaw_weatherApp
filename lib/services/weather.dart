import 'package:climaw/services/location.dart';
import 'package:climaw/services/api.dart';
import 'package:climaw/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&limit=5&appid=$apiKey&units=metric';
    Api api = Api(url);
    var weatherData = await api.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    Api api = Api(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await api.getData();

    return weatherData;
  }
}
