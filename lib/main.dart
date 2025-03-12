import 'package:flutter/material.dart';
import 'package:postogram/navigation/postogram_router.dart';
import 'package:postogram/uikit/theme/postogram_theme.dart';

void main() {
  runApp(const PostogramApp());
}

class PostogramApp extends StatelessWidget {
  const PostogramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: PostogramRouter.router, // Используем go_router
      theme: PostogramThemeData.lightTheme,
      darkTheme: PostogramThemeData.darkTheme,
    );
  }
}
