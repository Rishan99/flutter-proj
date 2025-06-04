import 'package:moviehub/core/constant/api_url.dart';
import 'package:moviehub/demodata.dart';
import 'package:moviehub/feature/auth/model/login_model.dart';
import 'package:moviehub/feature/auth/model/signup_model.dart';
import 'package:moviehub/services/core/http_service.dart';

class AuthService {
  final HttpService _httpService;

  AuthService(this._httpService);

  Future<dynamic> login(LoginModel model) async {
    var response = await _httpService.postDataJson(
      ApiUrl.login,
      data: model.toMap(),
    );
    return response;
  }

  Future<dynamic> register(SignupModel model) async {
    var data = await _httpService.postDataJson(ApiUrl.register, data: model.toMap());
    return data['message'];
  }
}
