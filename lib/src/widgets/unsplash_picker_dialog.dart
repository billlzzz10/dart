
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/api_keys.dart';

class UnsplashPickerDialog extends StatefulWidget {
  const UnsplashPickerDialog({super.key});

  @override
  State<UnsplashPickerDialog> createState() => _UnsplashPickerDialogState();
}

class _UnsplashPickerDialogState extends State<UnsplashPickerDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _imageUrls = [];
  bool _isLoading = false;
  String _currentQuery = '';
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // TODO: Fetch popular images on init
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchImages({bool loadMore = false}) async {
    if (_searchController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      if (!loadMore) {
        _imageUrls = [];
        _currentPage = 1;
      }
      _currentQuery = _searchController.text;
    });

    final url = Uri.parse(
        'https://api.unsplash.com/search/photos?query=$_currentQuery&page=$_currentPage&per_page=20&client_id=$unsplashAccessKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        setState(() {
          _imageUrls.addAll(results.map((e) => e['urls']['small'].toString()).toList());
          _currentPage++;
        });
      } else {
        // TODO: Handle API error
        print('Failed to load images');
      }
    } catch (e) {
      // TODO: Handle network error
      print('Error: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search on Unsplash'),
      content: SizedBox(
        width: double.maxFinite,
        height: 500, // Constrained height for the dialog
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for images...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchImages(),
                ),
              ),
              onSubmitted: (value) => _searchImages(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading && _imageUrls.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: _imageUrls.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Return the selected image URL
                            Navigator.of(context).pop(_imageUrls[index]);
                          },
                          child: Image.network(
                            _imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
            ),
            // TODO: Add load more button
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
