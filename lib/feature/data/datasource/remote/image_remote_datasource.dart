import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yummy_app/core/error/exceptions.dart';
import 'package:yummy_app/core/utils/constants/api.dart';
import 'package:yummy_app/core/utils/constants/messages.dart';

abstract interface class ImageRemoteDatasource {
  Future<String> searchForImage(String search);
}

class ImageRemoteDatasourceImpl implements ImageRemoteDatasource {
  final http.Client _client;

  ImageRemoteDatasourceImpl(this._client);

  @override
  Future<String> searchForImage(String search) async {
    final response = await _client.get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=$search&client_id=bCmS_BusUYjeERjOQn7cPUDxkkv9h8RrOnc2ejGhWcM'),
        headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];
      if (results != null || results.length > 0) {
        return results[0]['urls']['regular'];
      }
    }

    throw const ServerException(noServerConnection);
  }
}
