import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Image.network(
              post.imageUrl,
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
