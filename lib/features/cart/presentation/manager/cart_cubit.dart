import 'package:e_commerce_app/features/cart/domain/use_cases/add_productid_to_cart.dart';
import 'package:e_commerce_app/features/cart/domain/use_cases/get_cartlist.dart';
import 'package:e_commerce_app/features/cart/domain/use_cases/remove_productid_fromcart.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_state.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState>{
  GetCartList getCartList;
  AddProductIdToCartList addProductIdToCartList;
  RemoveProductIdFromCartList removeProductIdFromCartList;

  CartCubit({
    required this.getCartList,
    required this.addProductIdToCartList,
    required this.removeProductIdFromCartList

}) : super(CartInitial()) {
    getCart();
  }

  List<ProductEntity> cartList = [];
  void getCart() async {
    cartList = [];
    emit(CartLoading());
    final result = await getCartList();
    result.fold(
      (error) => emit(CartFailure(message:error.errMessage)),
      (list) {
        cartList.addAll(list);

        emit(CartSuccess());
        }
    );
  }
int totalPrice=0 ;
  int calculateTotalPrice() {
     totalPrice = 0;
    for (var element in cartList) {
      totalPrice += element.price.toInt();
    }
    emit(PriceUpdated());
    return totalPrice;
  }
  void addProductToCart(ProductEntity product) async {
    cartList.add(product);
    emit(CartSuccess());
    final result = await addProductIdToCartList(product.id.toInt());
    result.fold(
      (error) {
        cartList.remove(product);
        emit(CartFailure(message:error.errMessage));
      },
      (r) => emit(CartSuccess())
    );
  }


  void removeProductFromCart(ProductEntity product) async {
    cartList.remove(product);
    emit(CartSuccess());
    final result = await removeProductIdFromCartList(product.id.toInt());
    result.fold(
      (error) {
        cartList.add(product);
        emit(CartFailure(message:error.errMessage));
      },
      (r) => emit(CartSuccess())
    );
  }



}