import 'dart:convert';
import 'package:http/http.dart' as http;

class GifApiService {
  static const String apiKey = "E80PELCXzSswfnhWNaUyCV0q5k0wXpLX";

  static Future<List<String>?> getTrending(int offset, int limit) async {
    final url =
        "https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=$limit&offset=$offset";

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List<String>.from(data["data"]
            .map((e) => e["images"]["downsized_medium"]["url"].toString()));
      }
    } catch (_) {}
    return null;
  }

  static Future<List<String>?> searchGifs(String query, int offset, int limit) async {
    final url =
        "https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=$limit&offset=$offset";

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List<String>.from(data["data"]
            .map((e) => e["images"]["downsized_medium"]["url"].toString()));
      }
    } catch (_) {}
    return null;
  }
}
