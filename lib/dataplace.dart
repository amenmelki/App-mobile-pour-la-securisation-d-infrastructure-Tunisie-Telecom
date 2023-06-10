import 'package:flutter/material.dart';
import 'package:pfe_project/Dashboard/components/body.dart';
import 'Dashboard/components/body.dart';

class DataPlacesPage extends StatefulWidget {
  @override
  _DataPlacesPageState createState() => _DataPlacesPageState();
}

class _DataPlacesPageState extends State<DataPlacesPage> {
  List<String> dataPlaces = [
    'Manzah 4 Rue Ahmed Becha',
    'Ariana Rue Fadhel Ben Tayeb',
    'Touzen Rue Kamel eddine',
    'Sidi Hassin Rue Amen',
  ];
  List<String> dataPlaces2 = [
    '1214',
    '1378',
    '1974',
    '2022',
  ];

  List<String> dataPlaces3 = [
    'Manzah 1',
    'Ariana',
    'Zahrouni',
    'Ben Arrouss',
  ];
  String? selectedDataPlace = null;
  String? selectedChambre = null;
  String? selectedCategory1;
  String? selectedCategory2;
  String? selectedCategory3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 1,
        title: Text('Select Place'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/home1.png',
                height: 200,
              ),
              SizedBox(height: 30),
              DropdownButton<String>(
                value: selectedCategory1,
                hint: Text(
                  'Les Chambres Souterrain',
                  style: TextStyle(fontSize: 23),
                  textAlign: TextAlign.center,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCategory1 = value!;
                    selectedChambre = 'true';
                  });
                },
                // Added to change the text size
                underline: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                items: dataPlaces.map((dataPlace) {
                  return DropdownMenuItem<String>(
                    value: dataPlace,
                    child: Text(dataPlace),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCategory3,
                hint: Text(
                  '        Les Batiments',
                  style: TextStyle(fontSize: 23),
                  textAlign: TextAlign.center,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCategory3 = value!;
                  });
                },
                // Added to change the text size
                underline: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                items: dataPlaces.map((dataPlaces3) {
                  return DropdownMenuItem<String>(
                    value: dataPlaces3,
                    child: Text(dataPlaces3),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCategory2,
                hint: Text(
                  'Les Sites Radio',
                  style: TextStyle(fontSize: 23),
                  textAlign: TextAlign.center,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCategory2 = value!;
                  });
                },
                // Added to change the text size
                underline: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                items: dataPlaces2.map((dataPlaces2) {
                  return DropdownMenuItem<String>(
                    value: dataPlaces2,
                    child: Text(
                      dataPlaces2,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 150),
              SizedBox(
                width: 150, // Set the desired width
                height: 50,
                // Set the desired height
                child: ElevatedButton(
                  child: Text(
                    'Next ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: selectedCategory1 != null &&
                          selectedCategory2 == null &&
                          selectedCategory3 == null
                      ? () {
                          // Navigate to the dashboard page with the selected data place, category, and subcategory
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboardbody(),
                            ),
                          );
                        }
                      : null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      if (selectedCategory1 != null &&
                          selectedCategory2 == null &&
                          selectedCategory3 == null) {
                        return Colors.indigo;
                      } else {
                        return Colors.grey; // or any other color you want
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
