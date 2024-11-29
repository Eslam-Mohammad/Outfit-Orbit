import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/price_widget.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/services/service_locator_get_it.dart';



class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),

            BlocConsumer<WishlistCubit,WishlistState>(
                builder:  (context, state) {

                  if(state is WishlistLoading){
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(getIt<WishlistCubit>().wishlist.isEmpty){
                    return const Center(child: Text("No items in wishlist",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,i){
                    final wishlist = getIt<WishlistCubit>().wishlist.toList();
                     final product = wishlist[i];
                    return  SizedBox(
                      height: size.height * 0.25,
                      width:double.infinity,

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.20,
                            width: size.width*0.48,
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
                          const SizedBox(width: 10),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 5,),
                                Text(product.name,
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 10),
                                PriceWidget(price: product.price, oldPrice: product.oldPrice, discount: product.discount),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: product.rating.toDouble(),
                                      itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      direction: Axis.horizontal,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: () {


                                        if(getIt<WishlistCubit>().wishlist.contains(product)){
                                          getIt<WishlistCubit>().removeProductFromWishlist(product);
                                        }else{
                                          getIt<WishlistCubit>().addProductToWishlist(product);
                                        }


                                      },
                                      icon:getIt<WishlistCubit>().wishlist.contains(product)?const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),

                    );

                  }, separatorBuilder:(context,i){
                    return const Divider(thickness: 1,);
                  } ,
                      itemCount: getIt<WishlistCubit>().wishlist.length,
                  );
                },
                listener: (context, state) {
                  if(state is WishlistFailure){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("            Error has happened")));
                  }

                }
            ),
          ],
        ),
      ),
    );
  }
}
