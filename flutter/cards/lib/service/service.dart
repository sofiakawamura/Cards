import 'package:cards/models/monitor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Http {
  static String url = "http://localhost:8000/monitores";

  static getMonitores() async {
    List<Monitor> monitores = [];

    try {
      final res = await http.get(Uri.parse("${url}"));

      var data = jsonDecode(res.body);

      Map<String, List<String>> horarios = {
        "segunda": [],
        "terca": [],
        "quarta": [],
        "quinta": [],
        "sexta": [],
        "sabado": []
      };

      data['monitores'].forEach((monitor) => {
        monitor['horarios'].forEach((day) => {
          day.forEach((horario) => {
            horarios[day]!.add(horario['horario'])
          })
        }),

        monitores.add(Monitor(monitor['nome'], monitor['ra'], monitor['imagem'], horarios))
      });

      return monitores;
    }
    catch (error) {
      print(error.toString());
    }
  }
}