import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_camp/logic/home_cubit.dart';
import 'package:summer_camp/logic/home_state.dart';
import 'package:summer_camp/utills/custom_list_sports.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSportsBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sports'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://rubenlezcano.com/wp-content/uploads/2020/04/Diapositiva2-1-2048x1152.jpeg', 
                fit: BoxFit.cover,
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var cubit = HomeCubit.get(context);
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeError) {
                  return Center(child: Text('Failed to load books: ${state.message}'));
                } else if (cubit.sports.isEmpty) {
                  return const Center(child: Text('No items found'));
                } else {
                  return const CustomListSports();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
