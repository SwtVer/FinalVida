import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Utils {
  static Future<String> downloadFile(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filepath = '${directory.path}/$filename.png';
    final response = await http.get(Uri.parse(url));
    final file = File(filepath);
    await file.writeAsBytes(response.bodyBytes);
    return filepath;
  }
}
class DownloadUtil {
  static Future<String> downloadAndSaveFile(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filepath = '${directory.path}/$filename.png';
    final response = await http.get(Uri.parse(url));
    final file = File(filepath);
    await file.writeAsBytes(response.bodyBytes);
    return filepath;
  }
}
