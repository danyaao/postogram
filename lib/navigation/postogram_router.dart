import 'package:go_router/go_router.dart';
import 'package:postogram/feature/post_detail/post_detail_widget.dart';
import 'package:postogram/feature/post_grid/di/post_inherited.dart';
import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';

class PostogramRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PostGridFlow(),
      ),
      GoRoute(
        path: '/post',
        builder: (context, state) {
          final post = state.extra as Post;

          return PostDetailWidget(post: post);
        },
      ),
    ],
  );
}
