import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'model/movies_list.dart';
import 'util/strings.dart';

class MovieApiService {
  Client client = Client();

  Future<MoviesList> getMoviesList() async {
    final response = await client.get(
      Uri.parse(
        Strings.uriClient,
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      return MoviesList.fromJson(json.decode(
        response.body,
      ));
    } else {
      throw Exception(
        Strings.error,
      );
    }
  }
}
