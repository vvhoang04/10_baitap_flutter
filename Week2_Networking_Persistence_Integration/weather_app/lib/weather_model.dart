// lib/weather_model.dart

class Weather {
  final String cityName;
  final double temperature; // Nhiệt độ (Celsius)
  final String description; // Mô tả (vd: "mây rải rác")
  final String iconCode;    // Mã icon (vd: "04d")
  final int humidity;       // Độ ẩm (%)
  final double windSpeed;    // Tốc độ gió (m/s)
  final DateTime sunrise;   // Mặt trời mọc
  final DateTime sunset;    // Mặt trời lặn

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  // (Yêu cầu) JSON Parsing
  // Factory constructor để parse JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      // 'main' là một object, 'temp' là key bên trong nó
      temperature: (json['main']['temp']).toDouble(),
      // 'weather' là một List, ta lấy phần tử đầu tiên [0]
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed']).toDouble(),
      // 'sys' chứa thông tin sunrise/sunset (là timestamp)
      // Ta nhân 1000 để chuyển từ giây sang mili-giây
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
    );
  }

  // Hàm helper để lấy link icon
  String get iconUrl {
    // OpenWeatherMap cung cấp link ảnh icon
    return 'http://openweathermap.org/img/wn/$iconCode@4x.png';
  }
}