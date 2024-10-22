import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/services/service_locator_get_it.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_state.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';




class ProductsGrid extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeProductsFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("             ${state.message}")));
        }
      },
      builder: (context, state) {

        return GridView.count(
          childAspectRatio: 0.6,
          shrinkWrap: true,
          physics:  NeverScrollableScrollPhysics(),

          crossAxisCount: 2,
          children: List.generate(getIt<HomeCubit>().products.length, (index) {
            final product = getIt<HomeCubit>().products[index];
            return GestureDetector(
              onTap: (){
                GoRouter.of(context).push(itemDetailsPath,extra: product);
              },
              child: SizedBox(
                width:size.width*0.42,
                height: size.height*0.35,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width:size.width*0.42,
                        height: size.height*0.17,
                        child: Image.network(product.imageUrl,fit: BoxFit.contain,)),
                    SizedBox(height: 5,),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      product.name,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    PriceWidget(price: product.price, oldPrice:product.oldPrice, discount: product.discount),
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


                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }


}