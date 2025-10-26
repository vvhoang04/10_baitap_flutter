// lib/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'weather_model.dart';

class WeatherService {
  // Thay API Key của bạn vào đây
  static const String _apiKey = "416f5ccad0bb4e721388eb819cdc2311";
  static const String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  // Hàm chính: Lấy thời tiết dựa trên vị trí hiện tại
  Future<Weather> fetchCurrentWeather() async {
    try {
      // 1. Lấy vị trí (Yêu cầu: geolocator)
      Position position = await _getCurrentLocation();
      double lat = position.latitude;
      double lon = position.longitude;

      // 2. Gọi API thời tiết (Yêu cầu: http)
      // units=metric -> trả về độ C
      // lang=vi -> trả về mô tả tiếng Việt
      final String url = '$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=vi';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // 3. Parse JSON (Yêu cầu: JSON parsing)
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Failed to load weather (Status code: ${response.statusCode})');
      }
    } catch (e) {
      // Bắt các lỗi (ví dụ: từ chối quyền vị trí, lỗi mạng)
      throw Exception('Failed to fetch weather: $e');
    }
  }

  // Hàm helper để lấy vị trí và xử lý quyền
  Future<Position> _getCurrentLocation() async {
    // 1. Kiểm tra xem dịch vụ vị trí có bật không
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // 2. Kiểm tra quyền
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Nếu bị từ chối, yêu cầu lại
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Bị từ chối vĩnh viễn
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 3. Lấy vị trí
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium, // Độ chính xác trung bình
    );
  }
}