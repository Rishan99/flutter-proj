import 'package:moviehub/demodata.dart';
import 'package:moviehub/services/core/http_service.dart';
import 'package:moviehub/shared/model/movie_model.dart';

class MovieService {
  final HttpService _httpService;

  MovieService(this._httpService);

  Future<List<MovieModel>> getMostPopular() async {
    await demoDelay();
    var tt = [...movieData];
    tt.shuffle();
    return tt.take(5).toList();
    return [];
  }

  Future<List<MovieModel>> getRecentlyAdded() async {
    await demoDelay();
    var tt = [...movieData];
    tt.shuffle();
    return tt.take(5).toList();
    return [];
  }

  Future<List<MovieModel>> getFeatured() async {
    await demoDelay();
    var tt = [...movieData];
    tt.shuffle();
    return tt.take(5).toList();
  }

  Future<MovieModel> getDetailById(int id) async {
    // await demoDelay();
    return movieData.firstWhere((element) => element.id == id);
    // return {};
  }

  Future<List<MovieModel>> searchMovie(String query, int? genreId) async {
    await demoDelay();
    return movieData
        .where((element) =>
            (genreId == null ? true : element.genreId == genreId) &&
            (element.title.toLowerCase().contains(query.toLowerCase()) ||
                (element.description ?? "").toLowerCase().contains(
                      query.toLowerCase(),
                    )))
        .toList();
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

  Future<String> markAsView(int movieId) async {
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

  Future<String> rate(int movieId, double rating, String decsriptipn) async {
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
}
