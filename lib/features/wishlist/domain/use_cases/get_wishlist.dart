import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../home/domain/entities/home_entity.dart';

class GetWhishlist{

  final WishlistRepository repository;
  GetWhishlist(this.repository);

  Future<Either<Failure,List<ProductEntity>>> call() async {
    return await repository.getWishlist();
  }




}