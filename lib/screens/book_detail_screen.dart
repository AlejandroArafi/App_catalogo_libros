import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final Map book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Author: ${book['authors'] ?? 'Unknown'}'),
            SizedBox(height: 8),
            Text(
                'Description: ${book['description'] ?? 'No description available'}'),
          ],
        ),
      ),
    );
  }
}
