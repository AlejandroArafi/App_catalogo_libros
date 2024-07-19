import 'package:flutter/material.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> books = [
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookDetailScreen(bookTitle: books[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
