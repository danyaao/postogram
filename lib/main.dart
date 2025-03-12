import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  ThemeMode themeMode = ThemeMode.light;

  void changeTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: themeMode,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.black,
                onPrimary: Colors.white,
                secondary: Colors.white,
                onSecondary: Colors.black,
                error: Colors.red,
                onError: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black)),
        darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.white,
                onPrimary: Colors.black,
                secondary: Colors.black,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                surface: Colors.black,
                onSurface: Colors.white)),
        home: PostGrid(
          changeTheme: changeTheme,
        ));
  }
}

class Post {
  final String url;

  Post({required this.url});
}

class PostGrid extends StatefulWidget {
  final VoidCallback changeTheme;

  const PostGrid({required this.changeTheme, super.key});

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
        title: Image.asset(
          'assets/images/logo.png',
          width: 140,
          color: Theme.of(context).colorScheme.primary,
        ),
        actions: [
          Builder(builder: (innerContext) {
            return GestureDetector(
              onTap: () => showBottomSheet(
                  context: innerContext,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 48),
                        child: InkWell(
                          onTap: widget.changeTheme,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/theme.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Expanded(child: Text('Тема')),
                              const Text('Светлая')
                            ],
                          ),
                        ),
                      )),
              child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'assets/icons/more.svg',
                    width: 24,
                    height: 24,
                    colorFilter:
                        ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  )),
            );
          }),
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
