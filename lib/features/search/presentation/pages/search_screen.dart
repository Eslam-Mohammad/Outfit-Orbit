import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/services/service_locator_get_it.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../home/presentation/widgets/price_widget.dart';

import '../../../wishlist/presentation/manager/wishlist_cubit.dart';
import '../../../wishlist/presentation/manager/wishlist_state.dart';
import '../manager/search_cubit.dart';
import '../manager/search_state.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
final TextEditingController searchController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
final size = MediaQuery.of(context).size;
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // search bar
            SearchBar(

              onSubmitted: (value){
                print("******************** $value");
                getIt<SearchCubit>().searchMethod(value);

              },
              onChanged: (value){
                getIt<SearchCubit>().searchMethod(value);
              },

              hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
              controller: searchController2,
              hintText: "Search Any Product...",
              backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
              leading: const Icon(Icons.search,color: Colors.grey,),

            ),
            const SizedBox(
              height: 20,
            ),
            // search result
            BlocConsumer<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (getIt<SearchCubit>().filteredProducts.isEmpty) {
                    return const Center(
                        child: Text(
                          "No items in found",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      final searchList = getIt<SearchCubit>().filteredProducts.toList();
                      final product = searchList[i];
                      return SizedBox(
                        height: size.height * 0.25,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.20,
                              width: size.width * 0.38,
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
                    itemCount: getIt<SearchCubit>().filteredProducts.length,
                  );
                },
                listener: (context, state) {
                  if (state is SearchFailure) {
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text("            ${state.message}")));
                  }
                }),


          ],
        ),
      ),
    );
  }
  }




