import 'package:flutter/material.dart';



class SearchBarBuilder extends StatelessWidget {
  const SearchBarBuilder({super.key,required this.searchController});
 final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return SearchBar(


      onSubmitted: (value){
        print("******************** $value");


      },
      onChanged: (value){

      },

      hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
      controller: searchController,
      hintText: "Search Any Product...",
      backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
      leading: const Icon(Icons.search,color: Colors.grey,),

    );
  }
}
