import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postogram/feature/post_grid/di/post_inherited.dart';
import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';
import 'package:postogram/feature/post_grid/domain/repository/post_repository.dart';

abstract interface class IPostGridWidgetModel {
  ValueListenable<List<Post>> get posts;

  void init();

  Future<void> fetchPosts();

  void openDetails(Post post);
}

IPostGridWidgetModel createPostGridViewWidgetModel({
  required BuildContext context,
}) =>
    PostGridViewWidgetModel(
      context: context,
      postRepository: PostScopeInherited.of(context).postScope.postRepository,
    );

final class PostGridViewWidgetModel implements IPostGridWidgetModel {
  PostGridViewWidgetModel({
    required BuildContext context,
    required IPostRepository postRepository,
  })  : _context = context,
        _postRepository = postRepository;

  final BuildContext _context;

  final IPostRepository _postRepository;

  late final ValueNotifier<List<Post>> _posts = ValueNotifier<List<Post>>(
    [],
  );

  @override
  ValueListenable<List<Post>> get posts => _posts;

  @override
  void init() {
    unawaited(fetchPosts());
  }

  @override
  Future<void> fetchPosts() async {
    final posts = await _postRepository.getPosts();

    _posts.value = posts;
  }

  @override
  void openDetails(Post post) {
    _context.go('/post', extra: post);
  }
}
