
import 'package:e_commerce_app/core/connection/network_info.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
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
  print("*************************************************setup methos startes");

// Auth Cubit
  getIt.registerSingleton(InternetConnectionChecker());
  getIt.registerSingleton<NetworkInfo>( NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(()=> AuthLocalDataSource());
  getIt.registerLazySingleton<AuthRemoteDataSource>(()=> AuthRemoteDataSource());
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
// Auth Repository

// Auth Data Source

  getIt.registerSingleton<AuthCubit>(AuthCubit(
    signInWithGoogle: getIt(),
    signInWithEmailAndPassword: getIt(),
    signOut: getIt(),
    resetPassword: getIt(),
    signUpWithEmailAndPassword: getIt(),
  ));

///////////////////////////////////////////////////////////////////////////////////////




}