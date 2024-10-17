import 'dart:convert';


import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';

import '../../../../core/databases/cache/cache_helper.dart';



class AuthLocalDataSource {

  final String key = "CachedAuth";


  cacheAuth(AuthModel? authToCache) {
    if (authToCache != null) {
      CacheHelper.saveData(
        key: key,
        value: json.encode(
          authToCache.toJson(),
        ),
      );
    }
    else {
      throw CacheException(errorMessage: "No Internet Connection");
    }
  }



  Future<AuthModel> getLastCachedAuth() {
    final jsonString = CacheHelper.getDataString(key: key);

    if (jsonString != null) {
      return Future.value(AuthModel.fromJson(json.decode(jsonString)));
    }
    else {
      throw CacheException(errorMessage: "No Cached User");
    }
  }

  void clearCache() {
    CacheHelper.removeData(key: key);
  }


}
