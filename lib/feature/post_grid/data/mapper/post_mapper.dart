import 'package:postogram/api/data/post_multiple_dto.dart';
import 'package:postogram/feature/post_grid/domain/entity/post_entity.dart';

extension RemoteToDomain on PostMultipleDto {
  List<Post> toDomain() {
    return items
        .map(
          (item) => Post(
            imageUrl: item.sizes.first.url,
          ),
        )
        .toList();
  }
}
