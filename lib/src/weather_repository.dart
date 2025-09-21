import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'weather_repository.g.dart'; // MUST match the file name exactly

const String _apiKey = "a85318d922838bbf9664bb464fc704e1";

final cityProvider = StateProvider<String>((ref) => "Chennai");

class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

@riverpod
// ignore: deprecated_member_use_from_same_package
Future<Weather> weather(WeatherRef ref, String city) async {
  final url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_apiKey";

  final res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    return Weather.fromJson(jsonDecode(res.body));
  } else {
    throw Exception("City not found or API error");
  }
}
