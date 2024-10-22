import 'package:e_commerce_app/features/home/presentation/pages/home_screen.dart';
import 'package:e_commerce_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(


        title: SvgPicture.asset(Assets.imagesLogo5),
        actions: [
          IconButton(
            iconSize: 28,
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 28,
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body:HomeScreen(),
        bottomNavigationBar:ConvexAppBar(

          height: size.height * 0.06,
          color: Colors.black,
          activeColor: Colors.red,
          backgroundColor: Colors.white,
          style: TabStyle.textIn,
          items: const [
            TabItem(icon: Icons.home_outlined, title: 'Home'),
            TabItem(icon: Icons.favorite_border, title: 'Whishlist'),
            TabItem(icon: Icons.shopping_cart_outlined, title: 'Cart'),
            TabItem(icon: Icons.search, title: 'Search'),
            TabItem(icon: Icons.person_2_outlined, title: 'Profile'),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
      );

  }
}
