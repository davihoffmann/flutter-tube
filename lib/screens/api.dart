import 'dart:convert';

import 'package:fluttertube/model/video.dart';
import 'package:fluttertube/screens/api_key.dart';
import 'package:http/http.dart' as http;

class Api {

  search(String search) async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&chart=mostPopular&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Video> videos = decoded["items"]
          .map<Video>((video) => Video.fromJson(video))
          .toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}

/**
 * "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
   "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
   "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
 */
