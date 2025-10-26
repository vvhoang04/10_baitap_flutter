// lib/main.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl để format
import 'weather_model.dart';
import 'weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dùng theme tối cho đẹp
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Service của chúng ta
  final WeatherService _weatherService = WeatherService();

  // Future này sẽ giữ kết quả của việc gọi API
  late Future<Weather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    // Bắt đầu gọi API ngay khi màn hình được tạo
    _fetchWeather();
  }

  // Hàm gọi API và gán kết quả cho Future
  void _fetchWeather() {
    setState(() {
      _weatherFuture = _weatherService.fetchCurrentWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Weather'),
        actions: [
          // Nút Refresh để tải lại
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchWeather,
          ),
        ],
      ),
      // (Yêu cầu) Dùng FutureBuilder
      body: FutureBuilder<Weather>(
        future: _weatherFuture, // Future mà ta muốn theo dõi
        builder: (context, snapshot) {
          
          // 1. Trạng thái Đang Tải (Loading)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Getting your location & weather...'),
                ],
              ),
            );
          }

          // 2. Trạng thái Lỗi (Error)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 50),
                    SizedBox(height: 10),
                    Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _fetchWeather,
                      child: Text('Try Again'),
                    )
                  ],
                ),
              ),
            );
          }

          // 3. Trạng thái Thành Công (Success)
          if (snapshot.hasData) {
            final weather = snapshot.data!;
            // Hiển thị UI thời tiết
            return _buildWeatherUI(weather);
          }

          // Trạng thái mặc định (hiếm khi xảy ra)
          return Center(child: Text('Start fetching weather...'));
        },
      ),
    );
  }

  // Widget con để hiển thị UI thời tiết
  Widget _buildWeatherUI(Weather weather) {
    // Dùng intl để format giờ
    final DateFormat timeFormatter = DateFormat('HH:mm');
    final String sunriseTime = timeFormatter.format(weather.sunrise.toLocal());
    final String sunsetTime = timeFormatter.format(weather.sunset.toLocal());
    final String capitalizedDescription =
        weather.description[0].toUpperCase() + weather.description.substring(1);

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(), // Luôn cho phép cuộn
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Tên thành phố
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
            // Icon thời tiết (tải từ mạng)
            Image.network(weather.iconUrl, scale: 0.7),
            
            // Nhiệt độ
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.w300),
            ),
            
            // Mô tả
            Text(
              capitalizedDescription,
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 40),
            
            // Các chi tiết khác
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail(Icons.water_drop, 'Humidity', '${weather.humidity}%'),
                _buildWeatherDetail(Icons.air, 'Wind Speed', '${weather.windSpeed.toStringAsFixed(1)} m/s'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail(Icons.wb_sunny, 'Sunrise', sunriseTime),
                _buildWeatherDetail(Icons.nights_stay, 'Sunset', sunsetTime),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget helper cho các ô chi tiết (Độ ẩm, Gió, ...)
  Widget _buildWeatherDetail(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[400])),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ],
    );
  }
}