import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

/// Essa classe atua como nosso Controller, ou seja ela faz a 'ponte' entre nossa UI(VIEW) e no Repositorio(MODEL)
class UsersProvider extends ChangeNotifier {
  
  /// Instancia do repostorio com as funcoes que acessam a API
  final UserRepository _userRepository = UserRepository();
  
  /// Variavel privada responsavel por armazenar a listagem trazida da API
  List<UserModel> _userList = [];

  /// Get responsavel por fornecer acesso aos valores da variavel [_userList] fora da classe
  List<UserModel> get userList => _userList;

  Future<void> createUser(UserModel user) async {
    await _userRepository.createNewUserOnApi(user);
    notifyListeners();
  }

  Future<void> readUsers() async {
    await Future.delayed(const Duration(seconds: 3));
    _userList = await _userRepository.readUsersFromApi();
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await _userRepository.updateUserFromApi(user.id.toString(), user);
    notifyListeners();
  }

  Future<void> deleteUser(String userId) async {
    await _userRepository.deleteUserFromApi(userId);
    notifyListeners();
  }

}