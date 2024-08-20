import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 30, 32, 33), 
      ),
      backgroundColor: const Color.fromARGB(255, 20, 22, 23),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search',
            labelStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 229, 255, 0),
            ),
          ),
        ),
      ),
    );
  }
}
