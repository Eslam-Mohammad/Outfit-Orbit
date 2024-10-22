
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

class HomeStates{}
class HomeInitial extends HomeStates{}
class HomeProductsLoading extends HomeStates{}
class HomeProductsSuccess extends HomeStates {}
class HomeProductsFailure extends HomeStates{
  final String message;
  HomeProductsFailure(this.message);
}

class HomeBannersLoading extends HomeStates{}
class HomeBannersSuccess extends HomeStates{
  final List<BannerEntity> banners;
  HomeBannersSuccess(this.banners);
}
class HomeBannersFailure extends HomeStates{
  final String message;
  HomeBannersFailure(this.message);
}


