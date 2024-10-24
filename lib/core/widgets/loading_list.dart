import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder:(context,index)=> SizedBox(
        width: 100.0,
        height: 150.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Container(
            color: Colors.grey,

          ),
        ),
      ), separatorBuilder:(context,index)=> const SizedBox(width: 12.0,), itemCount: 4),
    );
  }
}
