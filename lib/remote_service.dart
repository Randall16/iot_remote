

import 'dart:developer';

import 'package:iot_remote/RemoteButton.dart';
import 'package:iot_remote/apiKey.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RemoteService {

  final String _IP_KEY = 'ip_address';

  String _url = 'NOT_SET';

  final SharedPreferences prefs;

  RemoteService(SharedPreferences sharedPreferences): prefs = sharedPreferences;

  void saveIpAddress(String ipAddress) async {
    prefs.setString(_IP_KEY, ipAddress);

    final tes = prefs.getString(_IP_KEY) ?? 'NOTHING';
    _url = 'http://$ipAddress:5000/api/';
  }

  Future<bool> sendButton(RemoteButton remoteButton) async {
    if (_url == 'NOT_SET') {
      loadIpAddress();
    }

    final uri = Uri.parse(_url + convertRemoteButtonToApiString(remoteButton));

    try {
      final response = await http.post(uri, headers: {'x-api-key': apiKey});
      return response.statusCode == 200;
    } catch(e) {
      log('An error occurred when making API call');
      return false;
    }

  }

  void loadIpAddress() async {
    _url = prefs.getString(_IP_KEY) ?? _url;
  }
}