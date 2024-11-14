import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/service_locator_get_it.dart';
import '../../../home/presentation/widgets/price_widget.dart';
import '../../../wishlist/presentation/manager/wishlist_cubit.dart';
import '../../../wishlist/presentation/manager/wishlist_state.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                BlocConsumer<CartCubit, CartState>(
                    builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (getIt<CartCubit>().cartList.isEmpty) {
                    return const Center(
                        child: Text(
                      "No items in Cart List",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      final cartList = getIt<CartCubit>().cartList.toList();
                      final product = cartList[i];
                      return SizedBox(
                        height: size.height * 0.25,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.20,
                              width: size.width * 0.48,
                              child: CachedNetworkImage(
                                imageUrl: product.imageUrl,
                                fit: BoxFit.contain,
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  PriceWidget(
                                      price: product.price,
                                      oldPrice: product.oldPrice,
                                      discount: product.discount),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      BlocBuilder<WishlistCubit, WishlistState>(
                                        builder: (context, state) {
                                          return IconButton(
                                            iconSize: 35,
                                            onPressed: () {
                                              if (getIt<WishlistCubit>()
                                                  .wishlist
                                                  .contains(product)) {
                                                getIt<WishlistCubit>()
                                                    .removeProductFromWishlist(
                                                        product);
                                              } else {
                                                getIt<WishlistCubit>()
                                                    .addProductToWishlist(
                                                        product);
                                              }
                                            },
                                            icon: getIt<WishlistCubit>()
                                                    .wishlist
                                                    .contains(product)
                                                ? const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : const Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.grey,
                                                  ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        iconSize: 35,
                                        onPressed: () {
                                          if (getIt<CartCubit>()
                                              .cartList
                                              .contains(product)) {
                                            getIt<CartCubit>()
                                                .removeProductFromCart(product);
                                          } else {
                                            getIt<CartCubit>()
                                                .addProductToCart(product);
                                          }
                                        },
                                        icon: const Icon(Icons.remove_shopping_cart),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return const Divider(
                        thickness: 1,
                      );
                    },
                    itemCount: getIt<CartCubit>().cartList.length,
                  );
                }, listener: (context, state) {
                  if (state is CartFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("            Error has happened")));
                  }
                }),
                Container(
                  height: size.height * 0.1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: size.height * 0.1,
            width: size.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Text(
                      "Total Price: ${getIt<CartCubit>().calculateTotalPrice()}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.fontSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // methods to create order and navigate to payment screen will be here
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
