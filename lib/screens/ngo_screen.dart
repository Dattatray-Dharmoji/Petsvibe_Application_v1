import 'package:flutter/material.dart';
import 'package:pets_vibe/models/ngo_model.dart';
import 'package:pets_vibe/services/api_service.dart';
import 'package:pets_vibe/widget/app_drawer.dart';
import 'package:pets_vibe/widget/ngo_card.dart';

class NGOScreen extends StatefulWidget {
  const NGOScreen({super.key});

  @override
  _NGOScreenState createState() => _NGOScreenState();
}

class _NGOScreenState extends State<NGOScreen> {
  List<NGO> ngoList = [];

  @override
  void initState() {
    super.initState();
    print("Fetching NGOs...");
    ApiService.fetchNGOs()
        .then((ngos) {
          print("Fetched NGOs: ${ngos.length}");
          setState(() {
            ngoList = ngos;
          });
        })
        .catchError((e) {
          print("Error fetching NGOs: $e");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Connect with NGOs"), centerTitle: true),
      body:
          ngoList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: ngoList.length,
                itemBuilder: (context, index) {
                  return NGOCard(
                    ngo: ngoList[index],
                    onSwiped: () {
                      // Swipe logic not required anymore
                    },
                  );
                },
              ),
    );
  }
}
