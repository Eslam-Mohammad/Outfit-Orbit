class WishlistState {}
class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}
class WishlistSuccess extends WishlistState {}
class WishlistFailure extends WishlistState {
  final String message;
  WishlistFailure({required this.message});
}


