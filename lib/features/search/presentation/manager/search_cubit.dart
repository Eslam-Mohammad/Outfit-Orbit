import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

import 'package:e_commerce_app/features/search/presentation/manager/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/home_model.dart';

class SearchCubit extends Cubit<SearchState> {


  SearchCubit() : super(SearchInitial()){
    getAllProducts();
  }

  List<ProductModel> productsForSearch = [];
 void getAllProducts()async {
   final allProducts = await FirebaseFirestore.instance.collection('products')
       .get();
   productsForSearch = allProducts.docs.map((e) =>
       ProductModel.fromJson(e.data() as Map<String, dynamic>)).toList();
    emit(SearchProductsListSuccess());
 }



   List<ProductEntity> filteredProducts = [];
   void searchMethod(String query){
     emit(SearchLoading());
     filteredProducts.clear();
     filteredProducts = productsForSearch.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();

     emit(SearchFilteredListSuccess());

   }


 }















