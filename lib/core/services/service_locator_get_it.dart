
import 'package:e_commerce_app/core/connection/network_info.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/get_admin_status.dart';
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
import '../../features/cart/data/data_sources/cart_local_datasource.dart';
import '../../features/cart/data/data_sources/cart_remote_datasource.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/use_cases/add_productid_to_cart.dart';
import '../../features/cart/domain/use_cases/get_cartlist.dart';
import '../../features/cart/domain/use_cases/remove_productid_fromcart.dart';
import '../../features/cart/presentation/manager/cart_cubit.dart';



import '../../features/chat/data/data_sources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/use_cases/delete_chat.dart';
import '../../features/chat/domain/use_cases/delete_message.dart';
import '../../features/chat/domain/use_cases/send_admin_message.dart';
import '../../features/chat/domain/use_cases/send_user_message.dart';
import '../../features/chat/presentation/manager/chat_cubit.dart';
import '../../features/search/presentation/manager/search_cubit.dart';
import '../../features/wishlist/data/data_sources/wishlist_local_datasource.dart';
import '../../features/wishlist/data/data_sources/wishlist_remote_datasource.dart';
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../features/wishlist/domain/use_cases/add_productid_towishlist.dart';
import '../../features/wishlist/domain/use_cases/get_wishlist.dart';
import '../../features/wishlist/domain/use_cases/remove_productid_fromwishlist.dart';
import '../../features/wishlist/presentation/manager/wishlist_cubit.dart';

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
  getIt.registerLazySingleton<GetAdminStatus>(() => GetAdminStatus(getIt()));

  // Auth Cubit
  getIt.registerSingleton<AuthCubit>(AuthCubit(
    signInWithGoogle: getIt(),
    signInWithEmailAndPassword: getIt(),
    signOut: getIt(),
    resetPassword: getIt(),
    signUpWithEmailAndPassword: getIt(),
    getAdminStatus: getIt(),
  ));
  ///////////////////////////////////////////////////////////////////////////////////////
  // wishlist data sources
  getIt.registerLazySingleton<WishlistRemoteDataSource>(()=> WishlistRemoteDataSource());
  getIt.registerLazySingleton<WishlistLocalDataSource>(()=> WishlistLocalDataSource());

  // wishlist repository
  getIt.registerLazySingleton<WishlistRepository>(()=> WishlistRepositoryImpl(
    networkInfo: getIt(),
    wishlistRemoteDataSource: getIt(),
    wishlistLocalDataSource: getIt(),
  ));
  // wishlist usecases
  getIt.registerLazySingleton<AddProductIdToWishlist>(() => AddProductIdToWishlist(getIt()));
  getIt.registerLazySingleton<GetWhishlist>(() => GetWhishlist(getIt()));
  getIt.registerLazySingleton<RemoveProductIdFromWishlist>(() => RemoveProductIdFromWishlist(getIt()));

  // wishlist cubit
  getIt.registerSingleton<WishlistCubit>(WishlistCubit(
    getWhishlist: getIt(),
    addProductIdToWishlist: getIt(),
    removeProductIdFromWishlist: getIt(),
  ));
  ////////////////////////////////////////////////////////////////////

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
////////////////////////////////////////////////////////////////////////////////////////
 // cart data sources
  getIt.registerLazySingleton<CartRemoteDataSource>(()=> CartRemoteDataSource());
  getIt.registerLazySingleton<CartLocalDataSource>(()=> CartLocalDataSource());
  // cart repository
  getIt.registerLazySingleton<CartRepository>(()=> CartRepositoryImpl(
    networkInfo: getIt(),
    cartListRemoteDataSource: getIt(),
    cartListLocalDataSource: getIt(),
  ));
  // cart usecases
  getIt.registerLazySingleton<AddProductIdToCartList>(() => AddProductIdToCartList(getIt()));
  getIt.registerLazySingleton<GetCartList>(() => GetCartList(getIt()));
  getIt.registerLazySingleton<RemoveProductIdFromCartList>(() => RemoveProductIdFromCartList(getIt()));
  // cart cubit
  getIt.registerSingleton<CartCubit>(CartCubit(
    getCartList: getIt(),
    addProductIdToCartList: getIt(),
    removeProductIdFromCartList: getIt(),
  ));
  ////////////////////////////////////////////////////////////////////////////////////////
  // search cubit
   getIt.registerSingleton<SearchCubit>(SearchCubit());

  ////////////////////////////////////////////////////////////////////////////////////////
  // chat cubit
  getIt.registerLazySingleton<ChatRemoteDataSource>(()=> ChatRemoteDataSource());
  // chat repository
  getIt.registerLazySingleton<ChatRepository>(()=> ChatRepositoryImpl(
    networkInfo: getIt(),
    chatRemoteDataSource: getIt(),
  ));
  // chat usecases
  getIt.registerLazySingleton<DeleteChat>(() => DeleteChat(getIt()));
  getIt.registerLazySingleton<DeleteMessage>(() => DeleteMessage(getIt()));
  getIt.registerLazySingleton<SendUserMessage>(() => SendUserMessage(getIt()));
  getIt.registerLazySingleton<SendAdminMessage>(() => SendAdminMessage(getIt()));
  // chat cubit
  getIt.registerLazySingleton<ChatCubit>(()=>ChatCubit(
    deleteChat: getIt(),
    deleteMessage: getIt(),
    sendUserMessage: getIt(),
    sendAdminMessage: getIt(),
  ));


}