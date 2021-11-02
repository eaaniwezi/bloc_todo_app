import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_todo_app/models/task.dart';

class UserRepository {
  static String baseUrl = "https://trello.backend.tests.nekidaem.ru";
  var loginUrl = '$baseUrl/api/v1/users/login/';
  var tasksUrl = '$baseUrl/api/v1/cards/';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String login, String password)  async{
    Response response = await _dio.post(loginUrl, data: {
      "username": login,
      "password": password,
    });
    print(response.data);
    return response.data["token"];
  }

  Future<List<Task>> fetchTask( ) async {
    var value = await storage.read(key: 'token');

    final response = await http.get(tasksUrl, headers: {
      'content-type': 'application/json',
      "Authorization" : "JWT " + value
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Task.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('error fetching tasks');
    }
  }


}