import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movies_app/src/core/resource/data_state.dart';
import '../../../../env/env.dart';
import '../../../core/util/api_service.dart';
import '../../../core/util/strings.dart';
import '../../../domain/entity/movies_list_entity.dart';
import '../../model/movies_list.dart';

class MovieApiService {
  Client client = Get.find<Client>();

  Future<DataState<MoviesListEntity>> getMoviesList() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiService.uri}${ApiService.endpointPopularMovies}${ApiService.apiKeyParameter}${Env.movieApiKey}',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        MoviesList moviesList = MoviesList.fromJson(
          json.decode(response.body),
        );
        if (moviesList.results.isNotEmpty) {
          return DataSuccess(
            moviesList,
          );
        } else {
          return const DataEmpty();
        }
      } else {
        return DataFailed(
          '${Strings.error} ${response.statusCode}',
        );
      }
    } catch (exception) {
      return DataFailed(
        '${Strings.error} ${exception.toString()}',
      );
    }
  }
}
