import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/errors/error_model.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/home/data/models/home_model.dart';

class HomeRemoteDataSource{
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;


  Future<List<BannerModel>> getBanners()async{

    try{
      final result= await FirebaseFirestore.instance.collection("banners").get()
          .then((value) => value.docs.map((e) => BannerModel.fromJson(e.data()as Map<String,dynamic>)).toList());
      return result;
    }catch(e){
      throw ServerException(ErrorModel(
          status:0,
          errorMessage: e.toString(),
      ));
    }
  }


  Future<List<ProductModel>> getProducts()async{
    if (_isLoading) return [];
    if (!_hasMore) throw RetryException(errorMessage: "No more products to load");
    _isLoading = true;
    try{



      Query query = FirebaseFirestore.instance.collection('products').orderBy('name').limit(4);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty ) {
        _lastDocument = querySnapshot.docs.last;

        _isLoading = false;
       return querySnapshot.docs.map((e) => ProductModel.fromJson(e.data() as Map<String,dynamic>)).toList();
      } else {
        _isLoading = false;
        _hasMore = false;
        return [];

      }



    }catch(e){
      throw ServerException(ErrorModel(
        status:0,
        errorMessage: e.toString(),
      ));
    }finally {
      _isLoading = false;
    }


  }






}