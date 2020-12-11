import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bookings/services/connection.dart';
import 'package:bookings/services/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';

abstract class Users with ChangeNotifier, ConnectionProvider {
  List<UserModel> _userList = [];
  dynamic _currentPage = 1;
  dynamic _totalPages;

  dynamic get currentPage {
    return _currentPage;
  }

  dynamic get totalPages {
    return _totalPages;
  }

  bool _fetchingUsers = false;

  List<UserModel> get userList {
    return List.from(_userList);
  }

  bool get fetchingUsers {
    return _fetchingUsers;
  }

  //get stores
  Future<Map<String, dynamic>> getUsers({bool loadMore}) async {
    try {
      _fetchingUsers = true;
      notifyListeners();
      String url = "$baseUrl/users?page=1";
      if (loadMore) {
        url = "$baseUrl/users?page=$_currentPage";
      }

      final response = await retry(
        () => http.get(url, headers: {
          'Content-type': 'application/json',
        }),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData.containsKey('data')) {
        final users = decodedData['data'];
        _totalPages = decodedData['total_pages'];
        List<UserModel> _tempUserList = [];

        var _tempUser;
        users.forEach((item) {
          var serialized = UserModel.fromJson(item);

          //  build users
          _tempUser = UserModel(
            id: serialized.id,
            email: serialized.email,
            firstName: serialized.firstName,
            lastName: serialized.lastName,
            avatar: serialized.avatar == null
                ? 'https://via.placeholder.com/150x150.png?text=No+avatar'
                : serialized.avatar,
          );

          _tempUserList.add(_tempUser);
        });

        // append users to existing list
        if (loadMore && _currentPage <= _totalPages) {
          _userList.addAll(_tempUserList);

          // increase _current page if its not the last page
          _currentPage++;
          _fetchingUsers = false;
          notifyListeners();
          return {'success': true, 'message': 'User fetched'};
        }

        _userList = _tempUserList;

        //  increase _currentPage if users is not empty and if its not the last page.
        if (users.length > 1) {
          _currentPage++;
        }

        _fetchingUsers = false;
        notifyListeners();
        return {'success': true, 'message': 'User fetched'};
      } else {
        _fetchingUsers = false;
        notifyListeners();
        return {'success': false, 'message': 'Unable to fetch user'};
      }
    } catch (error) {
      print('error occured $error');
      _fetchingUsers = false;
      notifyListeners();
      return {'success': false, 'msessage': 'failed'};
    }
  }

  resetCurrentPage() {
    _currentPage = 1;
    notifyListeners();
  }
}
