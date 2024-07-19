import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookTitle;

  BookDetailScreen({required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
      ),
      body: Center(
        child: Text('Book details for $bookTitle'),
      ),
    );
  }
}
