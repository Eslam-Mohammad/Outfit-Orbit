class SearchState{}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState{}
class SearchFailure extends SearchState{
  final String message;

  SearchFailure({required this.message});
}


class SearchProductsListSuccess extends SearchState{}

class SearchFilteredListSuccess extends SearchState{}