import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../utils/api_constants.dart';

class UserRepository {
  /// READ/GET/LER uma lista de usuario da API
  Future<List<UserModel>> readUsersFromApi() async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Iterable dataDecode = jsonDecode(response.body);

        final List<UserModel> userList =
            dataDecode.map((userJson) => UserModel.fromMap(userJson)).toList();

        return userList;
      }
    } catch (error, stack) {
      log('Ocorreu um erro ao RESGATAR LISTAGEM de usuarios',
          error: error, stackTrace: stack);
    }

    return [];
  }

  /// CREATE/POST/ENVIA um novo usuario na API
  Future<void> createNewUserOnApi(UserModel user) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users);

      final response = await http.post(
        uri,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: user.toJson(),
      );

      if (response.statusCode == 201) {
        log(response.body);
      } else {
        throw ('Erro ao cadastra usuario na API');
      }
    } catch (error, stack) {
      log('Ocorreu um erro ao SALVAR um novo usuario',
          error: error, stackTrace: stack);
    }
  }

  /// UPDATE/PUT/ATUALIZA um usuario na API
  Future<void> updateUserFromApi(String userId, UserModel user) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users + userId);

      final response = await http.put(
        uri,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        log(response.body);
      } else {
        throw ('Erro ao atualizar usuario');
      }
    } catch (error, stack) {
      log('Ocorreu um erro ao ATUALIZAR o usuario',
          error: error, stackTrace: stack);
    }
  }

  /// DELETE/DELATA um usuario da API
  Future<void> deleteUserFromApi(String userId) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.users + userId);

      final response = await http.delete(uri);
      
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
      } else {
        throw('Uuario deletado com sucesso!');
      }

    } catch (error, stack) {
      log('Ocorreu um erro ao DELETAR usuario',
          error: error, stackTrace: stack);
    }
  }
}
