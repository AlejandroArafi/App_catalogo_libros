import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final Map book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['volumeInfo']['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book['volumeInfo']['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
                'Author: ${book['volumeInfo']['authors']?.join(', ') ?? 'Unknown'}'),
            SizedBox(height: 8),
            Text(
                'Description: ${book['volumeInfo']['description'] ?? 'No description available'}'),
          ],
        ),
      ),
    );
  }
}
