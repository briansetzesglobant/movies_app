abstract class UseCaseInterface<T> {
  Future<T> call();
}
