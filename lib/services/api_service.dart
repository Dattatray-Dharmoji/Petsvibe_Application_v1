import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pets_vibe/models/ngo_model.dart';

class ApiService {
  static const String apiUrl =
      "http://192.168.0.183/pets_vibe_api/get_ngos.php";
  static Future<List<NGO>> fetchNGOs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((ngo) => NGO.fromJson(ngo)).toList();
    } else {
      throw Exception("Failed to load NGOs");
    }
  }
}
