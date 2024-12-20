import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/home/data/models/home_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/error_model.dart';
import '../../../../core/services/service_locator_get_it.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class CartRemoteDataSource{




  Future<Unit> addProductIdToCartList( int productId) async {
    try {

      if (getIt<AuthCubit>().theUserInformation!.documentId  != null) {
        // Get the document ID


        // Add or update the field in the found document
        await FirebaseFirestore.instance.collection('users').doc(getIt<AuthCubit>().theUserInformation!.documentId).update(
          {'cart': FieldValue.arrayUnion([productId])},
        );

        return unit;
      } else {

        throw ServerException(ErrorModel(errorMessage: "user not found",status: 500));
      }

    } catch (e) {

      throw ServerException(ErrorModel(errorMessage: e.toString(),status: 500));
    }
  }


  Future<Unit> removeProductIdFromCartList( int productId) async {
    try {
      // Query the collection to find the document with the specified email


      if (getIt<AuthCubit>().theUserInformation!.documentId !=null) {
        // Get the document ID


        // Add or update the field in the found document
        await FirebaseFirestore.instance.collection('users').doc(getIt<AuthCubit>().theUserInformation!.documentId).update(
          {'cart': FieldValue.arrayRemove([productId])},
        );

        return unit;
      } else {

        return unit;
      }

    } catch (e) {
      throw ServerException(ErrorModel(errorMessage: e.toString(),status: 500));
    }
  }



  Future<List<ProductModel>> getCartList() async {
    try {
      // Query the collection to find the document with the specified email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {



        // Get the document data
        Map<String, dynamic> documentData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Get the wishlist field
        List<dynamic> cartList = documentData['cart'];
// loop on products collection in firestore to get the products in the wishlist
        List<ProductModel> products = [];
        if (cartList.isNotEmpty) {
          QuerySnapshot productQuerySnapshot = await FirebaseFirestore.instance
              .collection('products')
              .where('id', whereIn: cartList)
              .get();
          for (var doc in productQuerySnapshot.docs) {
            products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
          }



        }
        return products;

      } else {

        throw ServerException(ErrorModel(errorMessage: 'Document not found',status: 404));
      }

    } catch (e) {
      throw ServerException(ErrorModel(errorMessage: e.toString(),status: 500));
    }
  }




}