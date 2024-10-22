import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';


class GetHomeBanners {
  final HomeRepository repository;

  GetHomeBanners(this.repository);

  Future<Either<Failure, List<BannerEntity>>> call() async {
    return await repository.getBanners();
  }
}