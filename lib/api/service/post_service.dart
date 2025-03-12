import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postogram/api/data/post_multiple_dto.dart';

class PostService {
  static const String _baseUrl = 'https://cloud-api.yandex.net/v1/disk/resources/files';
  static const String _token = 'y0_AgAAAAB2L-uYAADLWwAAAAELcwzsAAA6De9FER5NmryjnCAdpZIwFnDNZQ';

  PostService();

  Future<PostMultipleDto> getPosts() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'OAuth $_token',
      },
    );

    if (response.statusCode == 200) {
      return PostMultipleDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts: ${response.reasonPhrase}');
    }
  }
}
