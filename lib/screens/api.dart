import 'dart:convert';

import 'package:fluttertube/model/video.dart';
import 'package:fluttertube/screens/api_key.dart';
import 'package:http/http.dart' as http;

class Api {

  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    this._search = search;

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&chart=mostPopular&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&chart=mostPopular&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<Video> videos = decoded["items"]
          .map<Video>((video) => Video.fromJson(video))
          .toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}
