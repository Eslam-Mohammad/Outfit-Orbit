
import 'package:e_commerce_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CategoryBarBuilder extends StatelessWidget {
   CategoryBarBuilder({super.key});
 final List<String  > categories =[Assets.imagesFashion,Assets.imagesBeauty,Assets.imagesMens,Assets.imagesWomen,Assets.imagesKids];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            const Text("Categories",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            const Spacer(),
            InkWell(
              onTap: (){},
              child: SizedBox(child: SvgPicture.asset(Assets.imagesSort),
                height: 50,width: 100,
              ),
            ),
            InkWell(
              onTap: (){},
              child: SizedBox(
                width: 100,height: 50,
                child: SvgPicture.asset(Assets.imagesFilter),

              ),
            ),

          ],
        ),
        SizedBox(
          height: size.height*0.2,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) =>
                  InkWell(
                    onTap: (){},
                    child: Container(

                      height: size.height*0.2,
                      width: size.width*0.2,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,


                      ),
                      child:Image.asset(categories[index],fit: BoxFit.contain,) ,
                    ),
                  ),
              separatorBuilder: (context,index) => const SizedBox(width: 15,),
              itemCount:categories.length ),
        ),
      ],
    );
  }
}
