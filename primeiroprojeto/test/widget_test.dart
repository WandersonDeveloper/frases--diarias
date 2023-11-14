// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Anime {
  final String title;
  final String imageUrl;

  Anime({required this.title, required this.imageUrl});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimeSearchScreen(),
    );
  }
}

class AnimeSearchScreen extends StatefulWidget {
  @override
  _AnimeSearchScreenState createState() => _AnimeSearchScreenState();
}

class _AnimeSearchScreenState extends State<AnimeSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Anime> _searchResults = [];

  Future<void> _searchAnime(String title) async {
    final response = await http.get(
      Uri.parse('https://kitsu.io/api/edge/anime?filter[text]=$title'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        _searchResults = (data['data'] as List<dynamic>).map((animeData) {
          return Anime(
            title: animeData['attributes']['titles']['en'] ??
                animeData['attributes']['canonicalTitle'],
            imageUrl: animeData['attributes']['posterImage']['original'],
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load anime');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Explorer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for Anime by Title',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchAnime(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(_searchResults[index].imageUrl),
                        SizedBox(height: 8.0),
                        Text(_searchResults[index].title),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
