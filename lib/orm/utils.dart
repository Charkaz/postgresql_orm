
import 'dart:io';

class Utils{
  Future<void> createModelDaoDirectory() async {
    final directory = Directory("model_dao").create(recursive: true);
  }

  Future<bool> isCreatedDirectory() async {
    final myDir = Directory('dir');
    var isThere = await myDir.exists();
    return isThere;
  }
}