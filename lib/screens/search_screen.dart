import 'package:flutter/material.dart';
import 'package:pilem/screens/detail_screen.dart';

import '../models/movie.dart';
import '../services/api_service.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _serachResults = [];

  @override
  void iniState() {
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  Future<void> _searchMovies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _serachResults.clear();
      });
    }
    final List<Map<String, dynamic>> searchData =
    await _apiService.searchMovies(_searchController.text);
    setState(() {
      _serachResults = searchData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 1.0,
                  )),
              child: Row(
                children: [
                  Expanded(
                    //untuk test nya panjang
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                          hintText: 'Search Movies ...',
                          border: InputBorder.none),
                    ),
                  ),
                  Visibility(
                    visible: _searchController.text.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                  itemCount: _serachResults.length,
                  itemBuilder: (context, index) {
                    final Movie movie = _serachResults[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        leading: Image.network(
                          'https://image.tadb.org/t/p/w500${movie.posterPath}',
                          height: 50,
                          width: 50,
                        ),
                        title: Text(movie.title),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailScreen(movie: movie),
                              ),
                          );
                        },

                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
