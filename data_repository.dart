import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gui_db/program_model.dart';
import 'core.dart';

class DataRepository {
  static const baseUrl = core.baseUrl;

  Future<List<ProgramModel>> getPrograms() async {
    final url = Uri.parse('$baseUrl/programs');
    final response = await http.get(url);
    print('called url : $url');
    print('response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final List<ProgramModel> programs =
          responseBody.map((json) => ProgramModel.fromJson(json)).toList();
      return programs;
    } else {
      return [];
    }
  }

  Future<void> applyToProgram(String userId, String programName) async {
    final url = Uri.parse('$baseUrl/program/$userId/$programName');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to apply to program');
    }
  }
}
