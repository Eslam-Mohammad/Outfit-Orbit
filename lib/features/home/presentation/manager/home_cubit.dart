

import 'package:e_commerce_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/domain/use_cases/get_banners.dart';
import 'package:e_commerce_app/features/home/domain/use_cases/get_products.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_state.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:e_commerce_app/features/search/presentation/pages/search_screen.dart';
import 'package:e_commerce_app/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {

  GetHomeBanners getHomeBanners ;
  GetHomeProducts getHomeProducts;

  HomeCubit({required this.getHomeBanners,required this.getHomeProducts }) : super(HomeInitial()){
    getBanners();
    getProducts();

  }



int currentIndex = 0;
void changeIndex(int index){
  currentIndex = index;
  emit(HomeChangeIndex());
}
List<dynamic> appScreens=[
  HomeScreen(),
  const WishlistScreen(),
  const CartScreen(),
   SearchScreen(),
  const ProfileScreen(),

];




  List<BannerEntity>homeBanners = [];
  void getBanners()async{
    emit(HomeBannersLoading());
    final result = await getHomeBanners();
    result.fold((l){
      emit(HomeBannersFailure(l.errMessage));
    }, (r){
      homeBanners = r;
      emit(HomeBannersSuccess(r));
    });
  }



  List<ProductEntity> products = [];
  void getProducts()async{
    emit(HomeProductsLoading());
    final result = await getHomeProducts();
    result.fold((l){
      emit(HomeProductsFailure(l.errMessage));
    }, (r){
         products.addAll(r) ;
      emit(HomeProductsSuccess());
    });
  }
















}















