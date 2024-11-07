// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/post_model.dart';

class ApiService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<void> fetchAndStorePosts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> postJson = json.decode(response.body);
        final box = Hive.box<PostModel>('postsBox');

        for (var post in postJson) {
          final postModel = PostModel(
            id: post['id'] as int,
            title: post['title'] as String,
            body: post['body'] as String,
          );
          await box.add(postModel);
        }
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }
}