import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_state.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/services/service_locator_get_it.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../wishlist/presentation/manager/wishlist_cubit.dart';
import '../../../wishlist/presentation/manager/wishlist_state.dart';
import '../manager/home_cubit.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key , required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: size.width*0.19,
        height: size.height*0.09,
        child: FloatingActionButton(
          elevation: 30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: AppColors.fontSecondaryColor,
          onPressed: (){
            if(getIt<CartCubit>().cartList.contains(product)){
              getIt<CartCubit>().removeProductFromCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removed from Cart")));
            }else{
              getIt<CartCubit>().addProductToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Cart")));
            }
          },
          child: const Icon(
            color: Colors.white,
            size: 40,
              Icons.shopping_cart
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, state) {
              return IconButton(
                iconSize: 30,
               onPressed: (){
              if(getIt<WishlistCubit>().wishlist.contains(product)){
                getIt<WishlistCubit>().removeProductFromWishlist(product);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Removed from Wishlist")));
              }else{
                getIt<WishlistCubit>().addProductToWishlist(product);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to Wishlist")));
              }
            },
            icon: Icon(
              getIt<WishlistCubit>().wishlist.contains(product) ? Icons.favorite : Icons.favorite_border,
              color: AppColors.fontSecondaryColor,
            ),
          );
  },
),
          BlocBuilder<CartCubit,CartState>(
            builder: (context,state){
              return IconButton(
                iconSize: 35,
                onPressed: (){
                  getIt<HomeCubit>().changeIndex(2);
                  Navigator.pop(context);

                },
                icon:  Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,

                    ),
                    Positioned(
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.red,
                          child: Center(child: Text(getIt<CartCubit>().cartList.length.toString(),style: const TextStyle(color: Colors.white,fontSize: 12),)),
                        )
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
            CachedNetworkImage(
              imageUrl:  product.imageUrl,
              fit: BoxFit.contain,
              placeholder: (context,url){
                return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    color: Colors.grey,
                  ),
                );
              },
            ),

              const SizedBox(height: 20,),
              Text(product.name,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Text(product.description,style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 15,),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: product.rating.toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    product.votingNumber.toStringAsFixed(0),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.grey),),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
               children: [
                 Text(
                   '\$${product.price.toStringAsFixed(2)}',
                   style: const TextStyle(
                     color: Colors.black,
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 const SizedBox(width: 15,),
                 if(product.discount>0)
                 Text(
                   '\$${product.oldPrice.toStringAsFixed(2)}',
                   style: const TextStyle(
                     color: Colors.grey,
                     fontSize: 20,
                     decoration: TextDecoration.lineThrough,
                   ),
                 ),

                  const SizedBox(width: 20,),
                  if(product.discount>0)
                    Text(
                      '-${product.discount.toStringAsFixed(0)}%OFF',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
               ],
             ),
              const SizedBox(height: 10,),
             if (product.sizeAvailable != null)
                  ...[
                 const Text('Sizes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: List.generate(product.sizeAvailable!.length, (index) {
                      return Chip(
                        label: Text(product.sizeAvailable![index]),
                      );
                    }),
                  ),
                 const SizedBox(height: 10),
                 ],
              if (product.colorsAvailable != null)
                ...[
                  const Text('Colors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: List.generate(product.colorsAvailable!.length, (index) {
                     return Chip(
                           label: Text(product.colorsAvailable![index]),

                         );
                    }),
                  ),
                  const SizedBox(height: 10),
                ],


            ],
          ),
        ),
      ),
    );
  }
}
