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
      setState(() {
        books = data['items'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Catalogo de Flutter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.lightBlue[400]),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Color.fromARGB(255, 16, 198, 201),
                  ),
                  title: Text(
                    books[index]['volumeInfo']['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    books[index]['volumeInfo']['authors']?.join(', ') ??
                        'Autor Desconocido',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600], // Color del texto del subtítulo
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetailScreen(book: books[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
