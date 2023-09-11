import 'package:dio/dio.dart';

class NetWorkRequest {
  void changeDataRequest() async {
    Dio dio = Dio();
    try {
      var url = 'https://frontassignment.hyperhire.in/change';

      var data = {
        'description': 'Saad',
        'age': 21,
        'images': [],
        'location': 'sssss',
        'name': 'sssss'
      };

      Response response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
      } else {
        print('Request failed with status: ${response.data}');
        print('Error message: ${response.statusMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
