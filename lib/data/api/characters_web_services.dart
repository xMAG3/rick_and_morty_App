import 'package:bloc_app/constant/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      return response.data['results'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
