import 'package:envied/envied.dart';
import 'package:movies_app/util/api_service.dart';

part 'env.g.dart';

@Envied(path: 'assets/env/.env')
abstract class Env {
  @EnviedField(varName: ApiService.apiKey, obfuscate: true)
  static final movieApiKey = _Env.movieApiKey;
}
