import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  final Map book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title'] ?? 'No title'),
        backgroundColor: Color(0xFF5C6BC0), // Ajusta el color si es necesario
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book['title'] ?? 'No title',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Author: ${book['authors']?.join(', ') ?? 'Unknown'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'Description: ${book['description'] ?? 'No description available'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
