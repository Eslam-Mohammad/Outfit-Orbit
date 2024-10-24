 import 'dart:convert';

import 'package:e_commerce_app/core/databases/cache/cache_helper.dart';
import 'package:e_commerce_app/features/home/data/models/home_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';


class  WishlistLocalDataSource  {
final String wishlistKey ='wishlist';
void CacheWishlist(List<ProductModel> wishlist) {

  if(wishlist.isNotEmpty){
    var jsonModel = wishlist.map((e) => e.toJson()).toList();
    var jsonString = json.encode(jsonModel);
    CacheHelper.saveData(key: wishlistKey, value:jsonString );




  }
}


Future<List<ProductEntity>> getWishlist()async {
  List<ProductEntity> wishlist = [];
  if(await CacheHelper.containsKey(key: wishlistKey)){
    var jsonString = CacheHelper.getDataString(key: wishlistKey);
    if(jsonString != null){
      var jsonModel = json.decode(jsonString) as List;
      wishlist = jsonModel.map((e) => ProductModel.fromJson(e)).toList();
    }
  }
  return wishlist;
}


}