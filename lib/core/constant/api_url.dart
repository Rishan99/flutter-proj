// ignore_for_file: file_names

import 'package:moviehub/core/utility/environment.dart';

class ApiUrl {
  static bool get isDevEnv => getEnvironment is DevelopmentEnvironment;
  static String get baseUrl => getEnvironment.baseUrl;
}
