
import 'package:e_commerce_app/core/connection/network_info.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce_app/features/home/data/data_sources/home_remote_datasource.dart';
import 'package:e_commerce_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';
import 'package:e_commerce_app/features/home/domain/use_cases/get_banners.dart';
import 'package:e_commerce_app/features/home/domain/use_cases/get_products.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/reset_password.dart';
import '../../features/auth/domain/usecases/signin_google.dart';
import '../../features/auth/domain/usecases/signin_with_email_password.dart';
import '../../features/auth/domain/usecases/signout.dart';
import '../../features/auth/domain/usecases/signup_email_password.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {


//Auth data sources
  getIt.registerSingleton(InternetConnectionChecker());
  getIt.registerSingleton<NetworkInfo>( NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(()=> AuthLocalDataSource());
  getIt.registerLazySingleton<AuthRemoteDataSource>(()=> AuthRemoteDataSource());
  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(()=> AuthRepositoryImpl(
    localDataSource: getIt(),
    remoteDataSource: getIt(),
    networkInfo: getIt(),
  ));
// Auth UseCase
  getIt.registerLazySingleton<SignInWithGoogle>(() => SignInWithGoogle(repository: getIt()));
  getIt.registerLazySingleton<SignInWithEmailAndPassword>(() => SignInWithEmailAndPassword(getIt()));
  getIt.registerLazySingleton<SignOut>(() => SignOut(getIt()));
  getIt.registerLazySingleton<ResetPassword>(() => ResetPassword(getIt()));
  getIt.registerLazySingleton<SignUpWithEmailAndPassword>(() => SignUpWithEmailAndPassword(getIt()));

  // Auth Cubit
  getIt.registerSingleton<AuthCubit>(AuthCubit(
    signInWithGoogle: getIt(),
    signInWithEmailAndPassword: getIt(),
    signOut: getIt(),
    resetPassword: getIt(),
    signUpWithEmailAndPassword: getIt(),
  ));

///////////////////////////////////////////////////////////////////////////////////////
// home data sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(()=> HomeRemoteDataSource());
// home repository
  // Auth Repository
  getIt.registerLazySingleton<HomeRepository>(()=> HomeRepositoryImpl(

    remoteDataSource: getIt(),
    netWorkInfo: getIt(),
  ));
//home usecases
  getIt.registerLazySingleton<GetHomeBanners>(() => GetHomeBanners(getIt()));
  getIt.registerLazySingleton<GetHomeProducts>(() => GetHomeProducts(getIt()));
  //home cubit
  getIt.registerSingleton<HomeCubit>(HomeCubit(
    getHomeBanners: getIt(),
    getHomeProducts: getIt(),

  ));

}