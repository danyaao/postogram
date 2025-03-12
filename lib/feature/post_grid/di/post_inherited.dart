import 'package:flutter/material.dart';
import 'package:postogram/api/service/post_service.dart';
import 'package:postogram/feature/post_grid/data/repository/post_repository.dart';
import 'package:postogram/feature/post_grid/di/post_scope.dart';
import 'package:postogram/feature/post_grid/ui/post_grid_widget.dart';
import 'package:postogram/feature/post_grid/ui/post_grid_widget_model.dart';

class PostScopeInherited extends InheritedWidget {
  const PostScopeInherited({
    required this.postScope,
    required super.child,
    super.key,
  });

  final PostScope postScope;

  static PostScopeInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PostScopeInherited>();
  }

  static PostScopeInherited of(BuildContext context) {
    final scope = maybeOf(context);

    assert(scope != null, 'No PostScope found in context');

    return scope!;
  }

  @override
  bool updateShouldNotify(PostScopeInherited oldWidget) {
    return postScope != oldWidget.postScope;
  }
}

class PostGridFlow extends StatelessWidget {
  const PostGridFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final wm = PostGridViewWidgetModel(
      context: context,
      postRepository: PostRepository(
        postService: PostService(),
      ),
    );

    return PostScopeInherited(
      postScope: PostScope.create(context),
      child: PostGridWidget(
        wm: wm,
      ),
    );
  }
}
