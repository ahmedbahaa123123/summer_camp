import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:summer_camp/logic/home_state.dart';
import 'package:summer_camp/model/books_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of<HomeCubit>(context);

  List<BooksModel> sports = [];
  BooksModel? details; // Added this variable

  void getSportsBooks() async {
    emit(HomeLoading());
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=sports');
    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (result['totalItems'] > 0 && result['items'] != null) {
        debugPrint('success $result');
        sports = (result['items'] as List)
            .map((item) => BooksModel.fromMap(item as Map<String, dynamic>))
            .toList();
        emit(HomeSuccess());
      } else {
        debugPrint('No books found');
        emit(HomeError('No books found'));
      }
    } catch (e) {
      debugPrint('error ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }

  void getBookDetails(String bookId) async {
    emit(HomeLoading());
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes/$bookId');
    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (result != null) {
        debugPrint('success $result');
        details = BooksModel.fromMap(result as Map<String, dynamic>);
        emit(HomeSuccess());
      } else {
        debugPrint('No book details found');
        emit(HomeError('No book details found'));
      }
    } catch (e) {
      debugPrint('error ${e.toString()}');
      emit(HomeError(e.toString()));
    }
  }
}
