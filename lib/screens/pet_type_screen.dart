// lib/screens/pet_type_screen.dart
import 'package:flutter/material.dart';
import 'product_list_screen.dart';
import '../widgets/pet_type_card.dart';

class PetTypeScreen extends StatelessWidget {
  PetTypeScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> petTypes = [
    {'name': 'Dog', 'image': 'assets/images/dog.png'},
    {'name': 'Cat', 'image': 'assets/images/cat.png'},
    {'name': 'Bird', 'image': 'assets/images/bird.png'},
    {'name': 'Fish', 'image': 'assets/images/fish.png'},
    {'name': 'Rabbit', 'image': 'assets/images/rabbit.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Pet Type'),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: petTypes.length,
        itemBuilder: (context, index) {
          final pet = petTypes[index];
          return PetTypeCard(
            petType: pet['name']!,
            imagePath: pet['image']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListingScreen(petType: pet['name']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
