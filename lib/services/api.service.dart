import 'dart:convert';
import 'package:http/http.dart' as http;

enum CrudRequest {
  getMethod('GET'),
  postMehtod('POST'),
  putMethod('PUT'),
  deleteMethod('DELETE');

  const CrudRequest(this.enumName);
  final String enumName;
}

class ApiService {
  static successCallback(dynamic res) {}

  static errorCallback(int statusCode, String error) {}

  static Future<void> send(
    CrudRequest method,
    String path, {
    Object? body,
    bool cors = false,
    Function(dynamic) onSuccess = successCallback,
    Function(int, String) onError = errorCallback,
  }) async {
    var url = Uri.parse(path);
    if(cors){
      url = Uri.parse('https://corsproxy.io/?' + path);
    }

    try {
      switch (method) {
        case CrudRequest.getMethod:
        Map<String, String> headers = {};
          if (!cors) {
            headers = {
              '<Accept>': 'application/json'
            };
            print("Header YES");
          }
          print("Start GET Request");
          var response = await _handleGetRequest(url, headers);
          _handleResponse(response, onSuccess, onError);
          break;
        case CrudRequest.postMehtod:
          break;
        case CrudRequest.putMethod:
          break;
        case CrudRequest.deleteMethod:
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<http.Response> _handleGetRequest(
      Uri url, Map<String, String>? headers) async {
        if(headers!.isEmpty) {
          return await http.get(url, headers: headers);
        }
        else {
          return await http.get(url);
        }
    
  }

  static Future<void> _handleResponse(dynamic response,
      Function(dynamic) onSuccess, Function(int, String) onError) async {
    http.Response? httpResponse;

    if (response is http.StreamedResponse) {
      final responseBytes = await response.stream.toBytes();
      httpResponse = http.Response.bytes(
        responseBytes,
        response.statusCode,
        headers: response.headers,
        request: response.request,
      );
    } else if (response is http.Response) {
      httpResponse = response;
    }

    if (httpResponse != null) {
      if (httpResponse.statusCode == 200) {
        if (httpResponse.body.isNotEmpty) {
          if (httpResponse.headers['content-type']!
              .contains('application/json')) {
            var json = jsonDecode(httpResponse.body);
            onSuccess(json);
          } else {
            onSuccess(httpResponse.body.toString());
          }
        } else {
          onSuccess(null);
        }
      } else {
        onError(httpResponse.statusCode, httpResponse.body);
      }
    }
  }
}
