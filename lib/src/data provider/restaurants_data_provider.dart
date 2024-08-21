import 'package:fate_dating/src/models/restaurants_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/restaurants_service.dart';

final restaurantDataProvider = FutureProvider<List<RestaurantsModel>>((ref) async{
  return ref.watch(restaurantProvider).getUsers();

});