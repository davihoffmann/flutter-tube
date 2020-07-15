import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/model/video.dart';
import 'package:fluttertube/screens/api.dart';

class VideoBloc implements BlocBase {
  Api api;

  List<Video> videos;

  final StreamController _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final StreamController _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  VideoBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String query) async {
    videos = await api.search(query);

    print(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
  }

  @override
  void removeListener(listener) {
  }
}