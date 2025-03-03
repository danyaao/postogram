import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Постограм'),
          actions: [
            GestureDetector(
              onTap: () {},
              child:
                  const Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.more_vert)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (_, index) => SizedBox.square(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.network(
                        posts[index].url,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse('https://cloud-api.yandex.net/v1/disk/resources/files');

                    final response = await http.get(uri, headers: {
                      'Authorization':
                          'OAuth y0_AgAAAAB2L-uYAADLWwAAAAELcwzsAAA6De9FER5NmryjnCAdpZIwFnDNZQ'
                    });

                    if (response.statusCode != 200) {
                      throw Exception('Failed to load posts: ${response.reasonPhrase}');
                    }

                    final result = PostMultipleDto.fromJson(json.decode(response.body));

                    setState(() {
                      posts = result.items.map((item) => Post(url: item.sizes.first.url)).toList();
                    });
                  },
                  child: const Text('Загрузить ещё')),
            ],
          ),
        ),
      ),
    );
  }
}

class PostMultipleDto {
  final List<PostDto> items;

  PostMultipleDto({required this.items});

  factory PostMultipleDto.fromJson(Map<String, dynamic> json) {
    return PostMultipleDto(
      items: (json['items'] as List<dynamic>).map((item) => PostDto.fromJson(item)).toList(),
    );
  }
}

class PostDto {
  final String path;
  final List<PhotoDto> sizes;
  final DateTime created;

  PostDto({required this.path, required this.sizes, required this.created});

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      path: json['path'],
      sizes: (json['sizes'] as List<dynamic>).map((size) => PhotoDto.fromJson(size)).toList(),
      created: DateTime.parse(json['created']),
    );
  }
}

class PhotoDto {
  final String url;

  PhotoDto({required this.url});

  factory PhotoDto.fromJson(Map<String, dynamic> json) {
    return PhotoDto(url: json['url']);
  }
}

class Post {
  final String url;

  Post({required this.url});
}
