import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<BannerEntity>>> getBanners();
  Future<Either<Failure, List<ProductEntity> >> getProducts();
}