import 'package:flutter/material.dart';
import 'package:postogram/api/service/post_service.dart';
import 'package:postogram/feature/post_grid/data/repository/post_repository.dart';
import 'package:postogram/feature/post_grid/domain/repository/post_repository.dart';

final class PostScope {
  PostScope({required this.postRepository});

  factory PostScope.create(BuildContext context) {
    return PostScope(
      postRepository: PostRepository(postService: PostService()),
    );
  }

  final IPostRepository postRepository;
}
