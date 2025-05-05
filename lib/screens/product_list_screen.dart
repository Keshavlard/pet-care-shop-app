import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../data/product_data.dart';

class ProductListingScreen extends StatefulWidget {
  final String petType;

  const ProductListingScreen({required this.petType, Key? key}) : super(key: key);

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  bool isLoading = true;
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts(widget.petType);
  }

  void fetchProducts(String petType) {
    List<ProductModel> filteredProducts = [];

    for (var product in productData) {
      if (product['petType'] == petType) {
        filteredProducts.add(ProductModel.fromJson(product));
      }
    }

    setState(() {
      products = filteredProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.petType} Products'),
        backgroundColor: Colors.redAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
          ? const Center(
        child: Text(
          "No products found.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      color: Colors.redAccent,
                      onPressed: () {
                        // Handle cart logic
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../models/product_model.dart'; // Import the product model
// import '../data/product_data.dart'; // Import the local product data
//
// class ProductListingScreen extends StatefulWidget {
//   final String petType;
//
//   const ProductListingScreen({required this.petType, Key? key}) : super(key: key);
//
//   @override
//   _ProductListingScreenState createState() => _ProductListingScreenState();
// }
//
// class _ProductListingScreenState extends State<ProductListingScreen> {
//   bool isLoading = true;
//   List<ProductModel> products = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProducts(widget.petType);  // Fetch products based on selected pet type
//   }
//
//   // Filter products from local data based on the selected pet type
//   void fetchProducts(String petType) {
//     List<ProductModel> filteredProducts = [];
//
//     // Filter products based on the pet type
//     for (var product in productData) {
//       if (product['petType'] == petType) {
//         filteredProducts.add(ProductModel.fromJson(product));
//       }
//     }
//
//
//     setState(() {
//       products = filteredProducts;
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.petType} Products'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : products.isEmpty
//           ? const Center(child: Text("No products found."))
//           : ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ListTile(
//             leading: Image.network(product.imageUrl),
//             title: Text(product.name),
//             subtitle: Text('\$${product.price}'),
//             trailing: IconButton(
//               icon: const Icon(Icons.add_shopping_cart),
//               onPressed: () {
//                 // Handle adding to the cart
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
