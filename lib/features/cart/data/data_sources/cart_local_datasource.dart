import 'dart:convert';

import 'package:e_commerce_app/core/databases/cache/cache_helper.dart';
import 'package:e_commerce_app/features/home/data/models/home_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';


class  CartLocalDataSource  {
  final String cartListKey ='cartList';
  void cacheCartList(List<ProductModel> cartList) {

    if(cartList.isNotEmpty){
      var jsonModel = cartList.map((e) => e.toJson()).toList();
      var jsonString = json.encode(jsonModel);
      CacheHelper.saveData(key: cartListKey, value:jsonString );




    }
  }


  Future<List<ProductEntity>> getCachedCartList()async {
    List<ProductEntity> cartList = [];
    if(await CacheHelper.containsKey(key:cartListKey)){
      var jsonString = CacheHelper.getDataString(key: cartListKey);
      if(jsonString != null){
        var jsonModel = json.decode(jsonString) as List;
        cartList = jsonModel.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    return cartList;
  }


}