import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:e_commerce_app/features/wishlist/domain/use_cases/add_productid_towishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/use_cases/get_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/use_cases/remove_productid_fromwishlist.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator_get_it.dart';
import '../../../home/presentation/manager/home_state.dart';



class WishlistCubit extends Cubit<WishlistState>{
  GetWhishlist getWhishlist;
  AddProductIdToWishlist addProductIdToWishlist;
  RemoveProductIdFromWishlist removeProductIdFromWishlist;

  WishlistCubit({
    required this.getWhishlist,
    required this.addProductIdToWishlist,
    required this.removeProductIdFromWishlist,

}) : super(WishlistInitial()){
    getWishlist();
  }

  List<ProductEntity> wishlist = [];
  void getWishlist()async{
    wishlist= [];
    emit(WishlistLoading());
    final result = await getWhishlist();
    result.fold((l) {
      print("###################################################");
      print(l.errMessage);
      emit(WishlistFailure(message: l.errMessage));
    }, (r) {
      print("**********************************wish list filled");
      wishlist.addAll(r);
      print(wishlist.length);
      getIt<HomeCubit>().emit(HomeInitial());
      emit(WishlistSuccess());

    });
  }

  void addProductToWishlist(ProductEntity product)async{
     wishlist.add(product);
    emit(WishlistSuccess());
    final result = await addProductIdToWishlist(product.id.toInt());
    result.fold((l) {
      wishlist.remove(product);
      print("###################################################");
      print(l.errMessage);
      emit(WishlistFailure(message: l.errMessage));
    }, (r) {
      emit(WishlistSuccess());
    });


  }

  void removeProductFromWishlist(ProductEntity product)async{
    wishlist.remove(product);
    emit(WishlistSuccess());
    final result = await removeProductIdFromWishlist(product.id.toInt());
    result.fold((l) {
      wishlist.add(product);
      emit(WishlistFailure(message: l.errMessage));
    }, (r) {
      emit(WishlistSuccess());
    });
  }






}