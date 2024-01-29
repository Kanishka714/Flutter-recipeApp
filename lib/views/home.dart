import 'package:flutter/material.dart';
import 'package:reciepe/models/reciepe_api.dart';
import 'package:reciepe/models/recipe.dart';
import 'package:reciepe/views/widgets/recipe_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    List<Recipe> _recipes = [];
    bool _isLoading = true;

    @override
  void initState() {
    super.initState();

    getRecipes();
  }

    Future<void> getRecipes() async {
      try {
        _recipes = await RecipeApi.getRecipe();
        print(_recipes); // Print the result to check if data is received
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        print("Error fetching recipes: $error");
        // Handle error or show an error message
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('Food Recipe'),
        ],),
      ),
     body: _isLoading
         ? Center(child: CircularProgressIndicator())
         : ListView.builder(
         itemCount: _recipes.length,
         itemBuilder: (context, index){
       return RecipeCard(
           title: _recipes[index].name,
           cookTime: _recipes[index].totalTime,
           rating: _recipes[index].ratings.toString(),
           thumbnailUrl: _recipes[index].images,
       );
     }),
    );
  }
}
