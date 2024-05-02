import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CovidTracker(),
    );
  }
}

class CovidTracker extends StatefulWidget {
  @override
  _CovidTrackerState createState() => _CovidTrackerState();
}

class _CovidTrackerState extends State<CovidTracker> {
  Map<String, dynamic> _globalData = {};
  List<dynamic> _countries = [];
  String _selectedCountry = '';
  Map<String, dynamic> _countryData = {};

  @override
  void initState() {
    super.initState();
    fetchGlobalData();
    fetchCountries();
  }

  Future<void> fetchGlobalData() async {
    try {
      var response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
      if (response.statusCode == 200) {
        setState(() {
          _globalData = json.decode(response.body);
        });
      } else {
        print('Failed to load global data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCountries() async {
    try {
      var response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _countries = data.map((countryData) => countryData['country']).toList();
          _selectedCountry = _countries[0];
        });
        fetchCountryData(_selectedCountry);
      } else {
        print('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCountryData(String country) async {
    try {
      var response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries/$country'));
      if (response.statusCode == 200) {
        setState(() {
          _countryData = json.decode(response.body);
        });
      } else {
        print('Failed to load country data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Global COVID-19 Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _globalData.isEmpty
                ? CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirmed Cases: ${_globalData['cases']}'),
                      Text('Deaths: ${_globalData['deaths']}'),
                      Text('Recovered: ${_globalData['recovered']}'),
                    ],
                  ),
            SizedBox(height: 20),
            Text(
              'Country-wise COVID-19 Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              items: _countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                });
                fetchCountryData(_selectedCountry);
              },
            ),
            SizedBox(height: 10),
            _countryData.isEmpty
                ? CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirmed Cases: ${_countryData['cases']}'),
                      Text('Deaths: ${_countryData['deaths']}'),
                      Text('Recovered: ${_countryData['recovered']}'),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

