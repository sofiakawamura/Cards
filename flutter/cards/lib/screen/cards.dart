import 'package:cards/screen/horarios.dart';
import 'package:flutter/material.dart';
import 'package:cards/service/service.dart';
import 'package:cards/models/monitor.dart';

class Cards extends StatelessWidget {
  const Cards({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Monitores", style: TextStyle(fontWeight: FontWeight.bold)), 
        centerTitle: true,
        backgroundColor: Colors.white
      ),

      body: FutureBuilder(
        future: Http.getMonitores(), 
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            List<Monitor> data = snapshot.data;

            return PageView.builder(
              itemCount: data.length,
              itemBuilder: (context, posicao){
                return Container(
                  margin: EdgeInsets.all(30),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(20), 
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 35, top: 20),
                          child: Image.network(data[posicao].imagem)
                        ),

                        Text(
                          data[posicao].nome,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),

                        Text(
                          data[posicao].ra,
                          style: TextStyle(fontSize: 14),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(top: 30),

                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Horarios(monitor: data[posicao]),
                                ),
                              );
                            }, 
                            child: Text(
                              "Ver horários",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 3
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                          )
                        ),
                      ]
                    )
                  )
                );
              }
            );
          }
        }
      )
    );
  }
}