import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data provider/restaurants_data_provider.dart';

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier() : super('');

  void setSearch(String value) {
    state = value;
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, String>((ref) => SearchNotifier());

class Homepage extends ConsumerWidget {
  Homepage({Key? key}) : super(key: key);
    final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resturants = ref.watch(restaurantDataProvider);
    final searchTerm = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    ref.read(searchProvider.notifier).setSearch(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search restaurant...',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        searchController.clear();
                        ref.read(searchProvider.notifier).setSearch('');
                      },
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
            ),
            resturants.when(
              data: (restaurants) {
                final filteredRestaurants = restaurants.where((restaurant) {
                  return restaurant.name.toLowerCase().contains(searchTerm.toLowerCase());
                }).toList();

                return filteredRestaurants.isEmpty
                    ? const Center(child: Text("No Restaurant found!"))
                    : Column(
                        children: filteredRestaurants.map((e) {
                          return ListTile(
                            title: Text(
                              e.name,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              e.cuisine,
                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                            ),
                            leading: const Icon(Icons.restaurant),
                          );
                        }).toList(),
                      );
              },
              error: (err, s) => Text(err.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
