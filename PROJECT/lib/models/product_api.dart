import 'dart:convert';
import 'package:paytonkawa/models/product.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future<List<Product>> getProduct() async {
     var uri = Uri.https('https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products');
   /* var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});*/

    final response = await http.get(uri);

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Product.productsFromSnapshot(_temp);
  }
}