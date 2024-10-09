import 'package:flutter/material.dart';
import 'package:cards/service/service.dart';
import 'package:cards/models/monitor.dart';

class Cards extends StatelessWidget {
  const Cards({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Data"),
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
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(data[index].nome),
                  subtitle: Text(data[index].ra),
                  trailing: Text(data[index].horarios.toString(), textDirection: TextDirection.ltr)
                );
              }
            );
          }
        }
      )
    );
  }
}