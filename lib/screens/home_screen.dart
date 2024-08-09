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
    try {
      final response = await http.get(
          Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          books = data['items'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to load books')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the exception
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
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
        backgroundColor: const Color.fromARGB(255, 68, 186, 254),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: books.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final book = books[index]['volumeInfo'];
                return ListTile(
                  leading: const Icon(
                    Icons.book,
                    color: Color(0xFF5C6BC0),
                  ),
                  title: Text(
                    book['title'] ?? 'No title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    (book['authors'] ?? []).join(', ') ?? 'Autor Desconocido',
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
