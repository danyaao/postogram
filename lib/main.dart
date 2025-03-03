import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int itemCount = 10;

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
                  itemCount: itemCount,
                  itemBuilder: (_, index) => SizedBox.square(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.network(
                        'https://preview.redd.it/does-anyone-other-than-me-know-where-this-cat-is-from-lol-v0-img24gu05lfb1.jpg?width=1080&crop=smart&auto=webp&s=c3f0a1639fc3a21e04864423c108302d5a36ff8b',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () => setState(() {
                        itemCount += 10;
                      }),
                  child: const Text('Загрузить ещё')),
            ],
          ),
        ),
      ),
    );
  }
}
