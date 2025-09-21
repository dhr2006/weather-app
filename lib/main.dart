import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/weather_repository.dart'; // your existing repo
// ignore: depend_on_referenced_packages

void main() {
  runApp(
    ProviderScope(
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends ConsumerWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider);
    final weatherAsync = ref.watch(weatherProvider(city));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Fullscreen HD wallpaper based on weather
            weatherAsync.when(
              data: (weather) => Positioned.fill(
                child: Image.network(
                  getBackgroundImage(weather.description),
                  fit: BoxFit.cover,
                ),
              ),
              loading: () => Positioned.fill(
                child: Container(
                  color: Colors.blueGrey.shade200,
                ),
              ),
              error: (_, __) => Positioned.fill(
                child: Container(color: Colors.grey),
              ),
            ),

            // Optional Lottie animation overlay
            weatherAsync.when(
              data: (weather) => Positioned.fill(
                child: getWeatherAnimation(weather.description),
              ),
              loading: () => SizedBox.shrink(),
              error: (_, __) => SizedBox.shrink(),
            ),

            // Semi-transparent overlay to make content readable
            Positioned.fill(
              child: Container(
                color: Colors.black26,
              ),
            ),

            // Main content (search bar + weather card)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Styled search bar
                    Container(
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2)),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Search city...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ref.read(cityProvider.notifier).state = value;
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 30),

                    // Weather display
                    Expanded(
                      child: weatherAsync.when(
                        data: (weather) => Center(
                          child: WeatherCard(
                            city: weather.cityName,
                            temp: weather.temperature,
                            condition: weather.description,
                          ),
                        ),
                        loading: () => Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                        error: (err, _) => Center(
                            child: Text(
                          "Error: ${err.toString()}",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// WeatherCard Widget
class WeatherCard extends StatelessWidget {
  final String city;
  final double temp;
  final String condition;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temp,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    IconData weatherIcon;
    final lowerCondition = condition.toLowerCase();

    if (lowerCondition.contains('cloud')) {
      weatherIcon = Icons.cloud;
    } else if (lowerCondition.contains('sun') || lowerCondition.contains('clear')) {
      weatherIcon = Icons.wb_sunny;
    } else if (lowerCondition.contains('rain')) {
      weatherIcon = Icons.grain;
    } else {
      weatherIcon = Icons.wb_cloudy;
    }

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(2, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(weatherIcon, size: 70, color: Colors.white),
          SizedBox(height: 16),
          Text(city,
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text("${temp.toStringAsFixed(1)} °C",
              style: TextStyle(fontSize: 26, color: Colors.white)),
          SizedBox(height: 8),
          Text(condition,
              style: TextStyle(fontSize: 22, color: Colors.white)),
        ],
      ),
    );
  }
}

/// Random HD wallpaper based on weather
String getBackgroundImage(String condition) {
  final random = Random();
  final lowerCondition = condition.toLowerCase();

  List<String> cloudImages = [
    'https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=1280&q=80',
    'https://images.unsplash.com/photo-1499346030926-9a72daac6c63?auto=format&fit=crop&w=1280&q=80',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1280&q=80'
  ];

  List<String> sunImages = [
    'https://images.unsplash.com/photo-1501973801540-537f08ccae7d?auto=format&fit=crop&w=1280&q=80',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1280&q=80',
    'https://images.unsplash.com/photo-1494783367193-149034c05e8f?auto=format&fit=crop&w=1280&q=80'
  ];

  List<String> rainImages = [
    'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=1280&q=80',
    'https://images.unsplash.com/photo-1527766833261-b09c3163a791?auto=format&fit=crop&w=1280&q=80',
    'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1280&q=80'
  ];

  if (lowerCondition.contains('cloud')) {
    return cloudImages[random.nextInt(cloudImages.length)];
  } else if (lowerCondition.contains('sun') || lowerCondition.contains('clear')) {
    return sunImages[random.nextInt(sunImages.length)];
  } else if (lowerCondition.contains('rain')) {
    return rainImages[random.nextInt(rainImages.length)];
  } else {
    return sunImages[random.nextInt(sunImages.length)];
  }
}

/// Lottie animations based on weather
Widget getWeatherAnimation(String condition) {
  final lowerCondition = condition.toLowerCase();

  if (lowerCondition.contains('rain')) {
    return Lottie.network(
      'https://assets10.lottiefiles.com/packages/lf20_jmBauI.json',
      fit: BoxFit.cover,
      repeat: true,
    );
  } else if (lowerCondition.contains('cloud')) {
    return Lottie.network(
      'https://assets1.lottiefiles.com/packages/lf20_UJNc2t.json',
      fit: BoxFit.cover,
      repeat: true,
    );
  } else if (lowerCondition.contains('sun') || lowerCondition.contains('clear')) {
    return Lottie.network(
      'https://assets2.lottiefiles.com/packages/lf20_touohxv0.json',
      fit: BoxFit.cover,
      repeat: true,
    );
  } else {
    return SizedBox.shrink();
  }
}

class Lottie {static Widget network(String s, {required BoxFit fit, required bool repeat}) {
  return SizedBox.shrink(); // returns an empty widget
}
}