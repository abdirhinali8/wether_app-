import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Weather? weather;
  bool isLoading = false;
  final openWeather = WeatherFactory('093a43ca112b445889774752241708');
  String cityName = '';

  getWeather() async {
    try {
      setState(() {
        isLoading = true;
      });
      weather = await openWeather.currentWeatherByCityName(cityName);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('THE ERROR $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        title: const Text('Search by city name'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(22.0),
              child: TextField(
                onChanged: (value) {
                  cityName = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search by City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: getWeather,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: weather != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather!.temperature!.celsius!.round()} °C',
                          style: const TextStyle(
                            fontSize: 55.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weather!.weatherDescription}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'No weather data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
