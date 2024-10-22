import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

class BannerModel extends BannerEntity{
BannerModel({required super.name,required  super.imageUrl});
  factory BannerModel.fromJson(Map<String, dynamic> json){
    return BannerModel(
      name: json['name'],

      imageUrl: json['imageUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name':name,
      'imageUrl':imageUrl
    };
  }


}


class ProductModel extends ProductEntity{
ProductModel({required super.id,required  super.name,required  super.imageUrl,required  super.price,required  super.oldPrice,required  super.discount,required  super.description,required  super.rating,required  super.votingNumber, super.sizeAvailable, super.colorsAvailable});
  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      oldPrice: json['oldPrice'],
      discount: json['discount'],
      description: json['description'],
      rating: json['rating'],
      votingNumber: json['votingNumber'],
      sizeAvailable:json['sizeAvailable'] ,
      colorsAvailable:json['colorsAvailable']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'imageUrl':imageUrl,
      'price':price,
      'oldPrice':oldPrice,
      'discount':discount,
      'description':description,
      'rating':rating,
      'votingNumber':votingNumber,
      'sizeAvailable':sizeAvailable,
      'colorsAvailable':colorsAvailable
    };
  }
}