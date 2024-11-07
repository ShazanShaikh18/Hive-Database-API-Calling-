import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/post_model.dart';
import '../services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _apiService.fetchAndStorePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan.shade100,
        title: const Text('Posts', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
          body: ValueListenableBuilder(
            valueListenable: Hive.box<PostModel>('postsBox').listenable(),
            builder: (context, Box<PostModel> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No posts available'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final post = box.getAt(index);
                return Card(color: const Color.fromARGB(255, 235, 250, 252),
                  elevation: 5,
                  child: ListTile(
                    title: Text(post?.title ?? 'No Title',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text(post?.body ?? 'No Content'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}