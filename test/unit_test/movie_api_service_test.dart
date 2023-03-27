import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as client_library;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/data_state.dart';
import 'package:movies_app/env/env.dart';
import 'package:movies_app/model/movies_list.dart';
import 'package:movies_app/movie_api_service.dart';
import 'movie_api_service_test.mocks.dart';

@GenerateMocks([
  client_library.Client,
])
void main() {
  late MovieApiService movieApiService;
  late client_library.Client client;
  late String jsonStringSuccess;
  late String jsonStringEmpty;
  late String jsonStringFailed;
  late Map<String, dynamic> jsonDataSuccess;

  setUp(() {
    client = MockClient();
    Get.replace(client);
    movieApiService = MovieApiService();
    jsonStringEmpty = """{
      "page": 1,
      "results": [],
      "total_pages": 1,
      "total_results": 1
    }""";
    jsonStringFailed = """{
      "error": [],
    }""";
    jsonStringSuccess = """{
      "page": 1,
      "results": [
        {
          "adult": true,
          "backdrop_path": "backdrop_path",
          "genre_ids": [],
          "id": 1,
          "original_language": "original_language",
          "original_title": "original_title",
          "overview": "overview",
          "popularity": 1.0,
          "poster_path": "poster_path",
          "release_date": "release_date",
          "title": "title",
          "video": true,
          "vote_average": 1.0,
          "vote_count": 1
        }
      ],
      "total_pages": 1,
      "total_results": 1
    }""";
    jsonDataSuccess = {
      "page": 1,
      "results": [
        {
          "adult": true,
          "backdrop_path": "backdrop_path",
          "genre_ids": [],
          "id": 1,
          "original_language": "original_language",
          "original_title": "original_title",
          "overview": "overview",
          "popularity": 1.0,
          "poster_path": "poster_path",
          "release_date": "release_date",
          "title": "title",
          "video": true,
          "vote_average": 1.0,
          "vote_count": 1
        }
      ],
      "total_pages": 1,
      "total_results": 1
    };
  });

  group('MovieApiService test', () {
    test(
      'getMoviesList() should get the status success',
      () async {
        when(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).thenAnswer(
          (_) async => client_library.Response(
            jsonStringSuccess,
            HttpStatus.ok,
          ),
        );
        final response = await movieApiService.getMoviesList();
        verify(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).called(1);
        expect(
          response.data!.results.first.title,
          MoviesList.fromJson(
            jsonDataSuccess,
          ).results.first.title,
        );
        expect(
          response.error,
          null,
        );
      },
    );

    test(
      'getMoviesList() should get the status empty',
      () async {
        when(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).thenAnswer(
          (_) async => client_library.Response(
            jsonStringEmpty,
            HttpStatus.ok,
          ),
        );
        final response = await movieApiService.getMoviesList();
        verify(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          null,
        );
      },
    );

    test(
      'getMoviesList() should get the status failed',
      () async {
        when(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).thenAnswer(
          (_) async => client_library.Response(
            jsonStringFailed,
            HttpStatus.notFound,
          ),
        );
        final response = await movieApiService.getMoviesList();
        verify(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          'An error has occurred while loading movies: ${HttpStatus.notFound}',
        );
      },
    );

    test(
      'getMoviesList() should generate a exception',
      () async {
        Exception exception = Exception();
        when(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).thenThrow(exception);
        final response = await movieApiService.getMoviesList();
        verify(
          client.get(
            Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=${Env.movieApiKey}',
            ),
          ),
        ).called(1);
        expect(
          response.data,
          null,
        );
        expect(
          response.error,
          'An error has occurred while loading movies: ${exception.toString()}',
        );
        assert(response is DataFailed);
      },
    );
  });
}
