import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/home/data/models/home_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/error_model.dart';

class WishlistRemoteDataSource{




  Future<Unit> addProductIdToWishlist( int productId) async {
    try {
      print("***************************  remote method start");
      // Query the collection to find the document with the specified email
      print("*********************");
      print(FirebaseAuth.instance.currentUser!.email);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();

      print ("***************************  remote method after query");

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String documentId = querySnapshot.docs.first.id;

        // Add or update the field in the found document
        await FirebaseFirestore.instance.collection('users').doc(documentId).update(
          {'wishlist': FieldValue.arrayUnion([productId])},
        );
        print('Field added/updated successfully');
        return unit;
      } else {
        print('Document not found');
        throw ServerException(ErrorModel(errorMessage: "user not found",status: 500));
      }

    } catch (e) {
      print("***************************  remote method will throw");
     throw ServerException(ErrorModel(errorMessage: e.toString(),status: 500));
    }
  }


  Future<Unit> removeProductIdFromWishlist( int productId) async {
    try {
      // Query the collection to find the document with the specified email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String documentId = querySnapshot.docs.first.id;

        // Add or update the field in the found document
        await FirebaseFirestore.instance.collection('users').doc(documentId).update(
          {'wishlist': FieldValue.arrayRemove([productId])},
        );
        print('Field added/updated successfully');
        return unit;
      } else {
        print('Document not found');
        return unit;
      }

    } catch (e) {
     throw ServerException(ErrorModel(errorMessage: e.toString(),status: 500));
    }
  }



  Future<List<ProductModel>> getWishlist() async {
    try {
      // Query the collection to find the document with the specified email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {



        // Get the document data
        Map<String, dynamic> documentData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Get the wishlist field
       List<dynamic> wishlist = documentData['wishlist'];
// loop on products collection in firestore to get the products in the wishlist
List<ProductModel> products = [];
    if (wishlist.isNotEmpty) {
      QuerySnapshot productQuerySnapshot = await FirebaseFirestore.instance
      .collection('products')
      .where('id', whereIn: wishlist)
      .get();
          for (var doc in productQuerySnapshot.docs) {
            products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
           }



}
        return products;

      } else {
        print('Document not found');
        throw ServerException(ErrorModel(errorMessage: 'Document not found',status: 404));
      }

    } catch (e) {
      throw ServerException(ErrorModel(errorMessage: e.toString(),status: 500));
    }
  }




}