import 'package:postogram/api/service/post_service.dart';
import 'package:postogram/feature/post_grid/data/mapper/post_mapper.dart';
import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';
import 'package:postogram/feature/post_grid/domain/repository/post_repository.dart';

final class PostRepository implements IPostRepository {
  PostRepository({
    required PostService postService,
  }) : _postService = postService;

  final PostService _postService;

  @override
  Future<List<Post>> getPosts() async {
    final postMultipleResponse = await _postService.getPosts();

    final posts = postMultipleResponse.toDomain();

    return posts;
  }
}
