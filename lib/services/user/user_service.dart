import 'package:moviehub/demodata.dart';
import 'package:moviehub/services/core/http_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';

class UserService {
  final HttpService _httpService;

  UserService(this._httpService);
  Future<dynamic> getDetails() async {
    await demoDelay();
    return "Done";
  }

  Future<String> updateProfile(String name, String password) async {
    await demoDelay();
    return "Done";
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    await demoDelay();
    return "Changed";
    // var dataToSend = {
    //   "current_password": oldPassword,
    //   "new_password": newPassword,
    //   "new_password_confirmation": newPassword,
    // };
    // var data = await _httpService.putDataJson(ApiUrl.changePassword, data: dataToSend);
    // return data['message'];
  }

  Future<String> toggleFavourite(int movieId) async {
    await demoDelay();
    return "done";
    // var dataToSend = user.toMap();
    // if (user.image != null) {
    //   dataToSend.addAll({
    //     'image': await MultipartFile.fromFile(user.image!),
    //   });
    // }
    // var data = await _httpService.postDataFormData(ApiUrl.register, data: dataToSend);
    // return data['message'];
  }

  Future<List<MovieModel>> getFavouriteMovies() async {
    await demoDelay();
    var tt = [...movieData];
    tt.shuffle();
    return tt.take(5).toList();
  }
}
