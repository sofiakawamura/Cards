import 'package:cards/models/monitor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Http {
  static String url = "http://localhost:8000/";

  static getMonitores() async {
    List<Monitor> monitores = [];

    try {
      final res = await http.get(Uri.parse("${url}monitores"));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        for (var monitor in data) {
          Map<String, List<String>> horarios = {
            "Segunda": [],
            "Terça": [],
            "Quarta": [],
            "Quinta": [],
            "Sexta": [],
            "Sábado": []
          };

          List<String> dias = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
          
          for (int i = 0; i < monitor['horarios'].length; i++) {
            for (var horario in monitor['horarios'][i]) {
              horarios[dias[i]]!.add(horario['horario']);
            }
          }

          monitores.add(Monitor(
            monitor['nome'], 
            monitor['ra'], 
            monitor['imagem'], 
            horarios
          ));
        }
        return monitores;
      } 
      else {
        throw Exception("Erro ao carregar monitores");
      }
    } 
    catch (error) {
      print(error.toString());
    }
  }

  static getHorarios() async {
    List<String> horarios = [];

    try {
      final res = await http.get(Uri.parse("${url}horarios"));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        
        for (var horario in data) {
          horarios.add(horario);
        }

        return horarios;
      } 
      else {
        throw Exception("Erro ao carregar horários");
      }
    } 
    catch (error) {
      print(error.toString());
    }
  }
}