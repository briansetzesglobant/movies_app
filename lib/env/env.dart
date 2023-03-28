import 'package:envied/envied.dart';
import '../src/core/util/api_service.dart';

part 'env.g.dart';

@Envied(path: 'assets/env/.env')
abstract class Env {
  @EnviedField(varName: ApiService.apiKey, obfuscate: true)
  static final movieApiKey = _Env.movieApiKey;
}
