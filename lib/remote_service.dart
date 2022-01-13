

import 'dart:developer';

import 'package:iot_remote/RemoteButton.dart';
import 'package:iot_remote/apiKey.dart';
import 'package:http/http.dart' as http;


class RemoteService {

  late String _url;

  RemoteService(String ipAddress) {
    setIpAddress(ipAddress);
  }

  void setIpAddress(String ipAddress) {
    _url = 'http://$ipAddress:5000/api/';
  }

  Future<bool> sendButton(RemoteButton remoteButton) async {
    final uri = Uri.parse(_url + convertRemoteButtonToApiString(remoteButton));

    try {
      final response = await http.post(uri, headers: {'x-api-key': apiKey});
      return response.statusCode == 200;
    } catch(e) {
      log('An error occurred when making API call');
      return false;
    }

  }
}