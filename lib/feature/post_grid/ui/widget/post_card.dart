import 'package:flutter/material.dart';
import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onPostOpen,
  });

  final Post post;

  final VoidCallback onPostOpen;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: onPostOpen,
          child: Image.network(
            post.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
