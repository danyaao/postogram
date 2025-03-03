import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PostGrid());
  }
}

class Post {
  final String url;

  Post({required this.url});
}

class PostGrid extends StatefulWidget {
  const PostGrid({super.key});

  @override
  State<PostGrid> createState() => _PostGridState();
}

class _PostGridState extends State<PostGrid> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Постограм'),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.more_vert)),
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
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetails(
                                  post: posts[index],
                                )));
                      },
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

                  final result = (json.decode(response.body)['items'] as List<dynamic>)
                      .map((post) => Post(url: post['sizes'].first['url']))
                      .toList();

                  setState(() {
                    posts = result;
                  });
                },
                child: const Text('Загрузить ещё')),
          ],
        ),
      ),
    );
  }
}

class PostDetails extends StatelessWidget {
  const PostDetails({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Image.network(
              post.url,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
