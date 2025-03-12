import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';

abstract interface class IPostRepository {
  Future<List<Post>> getPosts();
}
