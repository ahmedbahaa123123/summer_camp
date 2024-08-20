import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:summer_camp/logic/auth_methos.dart';
import 'package:summer_camp/screens/books_screen.dart';
import 'package:summer_camp/screens/home_screen.dart';
import 'package:summer_camp/screens/profile_screen.dart';
import 'package:summer_camp/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final AuthMethods _authMethods = AuthMethods();

  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _authMethods.getUserDetails();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data!.data() != null) {
          final userData = snapshot.data!.data()!;
          final String username = userData['username'] ?? 'User';
          final String email = userData['email'] ?? 'email@example.com';
          
          // Convert age to int, handle the case where it might be a String or null
          final int age = userData['age'] != null 
              ? (userData['age'] is int 
                  ? userData['age'] as int 
                  : int.tryParse(userData['age'].toString()) ?? 0) 
              : 14;

          final List<Widget> _pages = <Widget>[
            HomeScreen(username: username),
            const BooksScreen(),
            ProfileScreen(
              username: username,
              email: email,
              age: age,
            ),
            SearchScreen(),
          ];

          return Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.green,
              selectedItemColor: Colors.black54,
              unselectedItemColor: Colors.black54,
              selectedLabelStyle: const TextStyle(color: Colors.black54),
              selectedFontSize: 14.0,
              unselectedLabelStyle: const TextStyle(color: Colors.black54),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_rounded),
                  label: 'Books',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('No user data found')),
          );
        }
      },
    );
  }
}
