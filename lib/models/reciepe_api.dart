import 'dart:convert';
import 'package:reciepe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi{

      // const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');
      //
      // req.query({
      //   limit: '24',
      //   start: '0'
      // });
      //
      // req.headers({
      // 'X-RapidAPI-Key': '2a9f7fd389mshf7395ccffafc827p130d94jsn18bf8570f805',
      // 'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'


  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.http('https://yummly2.p.rapidapi.com/feeds/list' , '/feeds/list' , {"limit": '24', "start": '0'
    });

    final response = await http.get(uri , headers: {'X-RapidAPI-Key': '2a9f7fd389mshf7395ccffafc827p130d94jsn18bf8570f805',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'});


    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']){
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}