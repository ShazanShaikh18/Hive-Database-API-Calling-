import 'package:hive/hive.dart';

import '../models/post_model.dart';


class Boxes {
  
  static Box<PostModel> getPostsBox() => Hive.box<PostModel>('notes');
}