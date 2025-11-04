import 'dart:convert'; // Для кодирования/декодирования JSON
import 'dart:io' show Platform; // Для определения платформы (Android/iOS)
import 'package:http/http.dart' as http; // Наш HTTP-клиент

class ApiService {
  final String _baseUrl = Platform.isAndroid 
    ? 'http://10.0.2.2:8050/api' 
    : 'http://localhost:8050/api';

  /// Запрашивает совет у Gemini API через наш бэкенд
  Future<String> fetchAiTip() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/gemini/ask'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'prompt': 'Дай очень короткий совет по уходу за зубами (одно предложение) на русском языке'}),
      );

      if (response.statusCode == 200) {
        // Успешно получили ответ
        final data = json.decode(response.body);
        return data['response'] ?? 'Не забывайте чистить зубы дважды в день!';
      } else {
        // Если сервер вернул ошибку
        print('Ошибка от сервера Gemini: ${response.body}');
        return 'Ошибка: Не удалось получить совет от ИИ.';
      }
    } catch (e) {
      // Если не удалось подключиться (сервер выключен или нет сети)
      print('Ошибка подключения: $e');
      return 'Ошибка: Не удалось подключиться к серверу.';
    }
  }

  /// Запрашивает клиники у Google Places API через наш бэкенд
  Future<Map<String, dynamic>> fetchClinics(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/places/dental-clinics?lat=$lat&lon=$lon'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Ошибка сервера при получении клиник'};
      }
    } catch (e) {
      return {'error': 'Ошибка подключения при получении клиник'};
    }
  }

  /// Получает список записей с нашего бэкенда
  Future<List<dynamic>> fetchAppointments() async {
     try {
      final response = await http.get(Uri.parse('$_baseUrl/appointments'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [{'error': 'Ошибка сервера при получении записей'}];
      }
    } catch (e) {
      return [{'error': 'Ошибка подключения при получении записей'}];
    }
  }

  // Сюда можно добавить методы createAppointment, deleteAppointment и т.д.
}
