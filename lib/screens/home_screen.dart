import 'package:app_catalogo_libros/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List books = [];
  bool isLoading = true;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      books = data['items'];

      // Insert books into the database
      for (var book in books) {
        await dbHelper.insertBook({
          'id': book['id'],
          'title': book['volumeInfo']['title'],
          'authors': (book['volumeInfo']['authors'] ?? []).join(', '),
          'description': book['volumeInfo']['description'] ?? '',
        });
      }

      setState(() {
        isLoading = false;
      });
    } else {
      // If the API call fails, try to load from the database
      books = await dbHelper.getBooks();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catálogo de Flutter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF5C6BC0),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: books.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Color(0xFF5C6BC0),
                  ),
                  title: Text(
                    book['volumeInfo']['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    book['volumeInfo']['authors']?.join(', ') ??
                        'Autor Desconocido',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
