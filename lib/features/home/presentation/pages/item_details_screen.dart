import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
          onPressed: (){},
          child: Icon(
            color: Colors.white,
            size: 40,
              Icons.shopping_cart
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Image.network(product.imageUrl,fit: BoxFit.contain,),
              SizedBox(height: 20,),
              Text(product.name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(product.description,style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: product.rating.toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "${product.votingNumber.toStringAsFixed(0)}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.grey),),
                ],
              ),
              SizedBox(height: 15,),
              Row(
               children: [
                 Text(
                   '\$${product.price.toStringAsFixed(2)}',
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 SizedBox(width: 15,),
                 if(product.discount>0)
                 Text(
                   '\$${product.oldPrice.toStringAsFixed(2)}',
                   style: TextStyle(
                     color: Colors.grey,
                     fontSize: 20,
                     decoration: TextDecoration.lineThrough,
                   ),
                 ),

                  SizedBox(width: 20,),
                  if(product.discount>0)
                    Text(
                      '-${product.discount.toStringAsFixed(0)}%OFF',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
               ],
             ),
              SizedBox(height: 10,),
             if (product.sizeAvailable != null)
                  ...[
                 Text('Sizes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: List.generate(product.sizeAvailable!.length, (index) {
                      return Chip(
                        label: Text(product.sizeAvailable![index]),
                      );
                    }),
                  ),
                 SizedBox(height: 10),
                 ],
              if (product.colorsAvailable != null)
                ...[
                  Text('Colors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: List.generate(product.colorsAvailable!.length, (index) {
                     return Chip(
                           label: Text(product.colorsAvailable![index]),

                         );
                    }),
                  ),
                  SizedBox(height: 10),
                ],


            ],
          ),
        ),
      ),
    );
  }
}
