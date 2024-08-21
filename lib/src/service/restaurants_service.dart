import 'dart:convert';

import 'package:fate_dating/src/models/restaurants_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantsService {
  // 
 String userUrl = 'http://localhost:3000/data';

  Future<List<RestaurantsModel>> getResutrant() async {
    final response = await http.get(Uri.parse(userUrl));
    print("the status code is ${response.statusCode} ${jsonDecode(response.body)}");
   try {
      if (response.statusCode == 200) {
      final List<dynamic> result = json.decode(response.body);
      return result.map((e) => RestaurantsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load resturant');
    }
   } catch (e) {
      throw Exception('Failed to load users');
   }
  }
}

final restaurantProvider = Provider<RestaurantsService>((ref) => RestaurantsService());