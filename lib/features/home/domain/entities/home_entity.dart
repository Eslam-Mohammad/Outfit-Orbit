class BannerEntity{
  final String name;
  final String imageUrl;
  BannerEntity({required this.name,required this.imageUrl});
}


class ProductEntity{
  final num id;
  final String name;
  final String imageUrl;
  final num price;
  final num oldPrice;
  final num discount;
  final String description;
  final num rating;
  final num votingNumber;
  final List<dynamic>? sizeAvailable;
  final List<dynamic>? colorsAvailable;

  ProductEntity({required this.id,required this.name,required this.imageUrl,required this.price,required this.oldPrice,required this.discount,required this.description,required this.rating,required this.votingNumber, this.sizeAvailable, this.colorsAvailable});


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;


}