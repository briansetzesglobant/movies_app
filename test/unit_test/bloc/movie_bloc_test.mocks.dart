// Mocks generated by Mockito 5.4.0 from annotations
// in movies_app/test/bloc/movie_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movies_app/src/core/resource/data_state.dart' as _i4;
import 'package:movies_app/src/data/repository/movie_repository.dart' as _i2;
import 'package:movies_app/src/domain/entity/movies_list_entity.dart' as _i7;
import 'package:movies_app/src/domain/use_case/implementation/movie_use_case.dart'
    as _i5;
import 'package:movies_app/src/strategy/sorting_strategy_interface.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMovieRepository_0 extends _i1.SmartFake
    implements _i2.MovieRepository {
  _FakeMovieRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSortingStrategyInterface_1 extends _i1.SmartFake
    implements _i3.SortingStrategyInterface {
  _FakeSortingStrategyInterface_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDataState_2<T> extends _i1.SmartFake implements _i4.DataState<T> {
  _FakeDataState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieUseCase extends _i1.Mock implements _i5.MovieUseCase {
  MockMovieUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get sortingWay => (super.noSuchMethod(
        Invocation.getter(#sortingWay),
        returnValue: false,
      ) as bool);
  @override
  _i2.MovieRepository get movieRepository => (super.noSuchMethod(
        Invocation.getter(#movieRepository),
        returnValue: _FakeMovieRepository_0(
          this,
          Invocation.getter(#movieRepository),
        ),
      ) as _i2.MovieRepository);
  @override
  _i3.SortingStrategyInterface get sortingStrategyInterface =>
      (super.noSuchMethod(
        Invocation.getter(#sortingStrategyInterface),
        returnValue: _FakeSortingStrategyInterface_1(
          this,
          Invocation.getter(#sortingStrategyInterface),
        ),
      ) as _i3.SortingStrategyInterface);
  @override
  _i6.Future<_i4.DataState<_i7.MoviesListEntity>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i6.Future<_i4.DataState<_i7.MoviesListEntity>>.value(
            _FakeDataState_2<_i7.MoviesListEntity>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i6.Future<_i4.DataState<_i7.MoviesListEntity>>);
}
