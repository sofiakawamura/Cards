import 'package:flutter/material.dart';
import 'package:cards/models/monitor.dart';
import 'package:cards/service/service.dart';

class Horarios extends StatelessWidget {
  final Monitor monitor;
  Horarios({super.key, required this.monitor});

  @override
  Widget build(BuildContext context) {
    List<String> dias = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(monitor.nome, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: FutureBuilder(
        future: Http.getHorarios(), 
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            List<String> horarios = snapshot.data;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        Center(child: const Text("Horário", style: TextStyle(fontWeight: FontWeight.bold))),

                        ...dias.map((dia) => Center(
                          child: Text(
                            dia, 
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          )
                        )),
                      ],
                    ),

                    ...horarios.map((horario) => TableRow(
                      children: [
                        Center(child: Text(horario)),

                        ...dias.map((dia) => 
                          Container(
                            color: monitor.horarios[dia]!.contains(horario) ? Colors.green : Colors.white,
                            child: Text("")
                          )
                        ),
                      ],
                    ))
                  ],
                )
              )
            );
          }
        }
      )
    );
  }
}