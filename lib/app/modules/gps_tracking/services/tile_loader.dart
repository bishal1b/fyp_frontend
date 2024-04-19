import 'package:http/http.dart' as http;
import 'dart:async';

class TileLoader {
  static const String tileUrl =
      "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  static const int maxRetries = 3;
  static const Duration initialRetryDelay = Duration(seconds: 1);

  static Future<http.Response> loadTile(int zoom, int x, int y) async {
    int retryCount = 0;
    Duration retryDelay = initialRetryDelay;
    late http.Response response;

    while (retryCount < maxRetries) {
      try {
        response = await http.get(Uri.parse(tileUrl
            .replaceAll("{z}", "$zoom")
            .replaceAll("{x}", "$x")
            .replaceAll("{y}", "$y")));
        if (response.statusCode == 200) {
          return response;
        } else {
          throw http.ClientException(
              "Failed to load tile. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error loading tile: $e");
        retryCount++;
        await Future.delayed(retryDelay);
        retryDelay *= 2; // Exponential backoff
      }
    }

    throw http.ClientException(
        "Failed to load tile after $maxRetries attempts");
  }
}
