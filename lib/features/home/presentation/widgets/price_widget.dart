import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final num price;
  final num oldPrice;
  final num discount;

  const PriceWidget({
    super.key,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (oldPrice > 0)
          Row(
            children: [
              Text(
                '\$${oldPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              if (discount > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '-${discount.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}