import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future getSingleImagePath() async {
  String SingleFilePath;
  SingleFilePath = await FilePicker.getFilePath(type: FileType.image);
  return SingleFilePath;
}

Future getMultiImagesPath() async {
  Map<String, String> imagesPaths;
  imagesPaths = await FilePicker.getMultiFilePath(type: FileType.image);

//  Options
//  List<String> allNames = filePaths.keys; // List of all file names
//  List<String> allPaths = filePaths.values; // List of all paths
//  String someFilePath = filePaths['fileName']; // Access a file path directly by its name (matching a key)

  return imagesPaths;
}

Future getSingleFilePath() async {
  String filesPath = await FilePicker.getFilePath();
  return filesPath;
}

Future<Map<String, String>> getMultiFilesPath() async {
  Map<String, String> filesPaths;
  filesPaths = await FilePicker.getMultiFilePath(type: FileType.any);

//  Options
//  List<String> allNames = filesPaths.keys; // List of all file names
//  List<String> allPaths = filesPaths.values; // List of all paths
//  String someFilePath = filesPaths['fileName']; // Access a file path directly by its name (matching a key)

  return filesPaths;
}

Future getImageFileFromCamera() async {
  var picker = ImagePicker();
  PickedFile imageFile =
      await picker.getImage(source: ImageSource.camera, imageQuality: 50);
  if (imageFile != null) {
    return File(imageFile.path).path;
  }
}
