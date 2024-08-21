import 'package:fate_dating/src/data%20provider/restaurants_data_provider.dart';
import 'package:fate_dating/src/models/restaurants_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final resturants =  ref.watch(restaurantDataProvider);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("restaurant"),
      ),
      body: resturants.when(
        data: (resturants){
          List<RestaurantsModel> res = resturants.map((res) =>res).toList();
          return Column(
            children: res.map((e) => ListTile(
              title: Text(e.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              subtitle: Text(e.cuisine,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),),
              leading: const Icon(Icons.restaurant),
            )).toList(),
          );
        }, 
        error: (err,s) => Text(err.toString()), 
        loading: () => const Center(child:  CircularProgressIndicator())),
    );
  }
}