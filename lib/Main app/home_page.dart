// home_screen.dart
import 'package:flutter/material.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/models/laptop_model.dart';
import 'package:kings_connect/providers/cart_page.dart';
import 'package:kings_connect/widgets/product_card.dart';
//import 'package:kings_connect/widgets/product_card.dart'; // Import the ProductCard widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ['All', 'HP', 'Dell', 'Lenovo'];
  int selectedCategory = 0;

  // Sample data for the grid view (replace with your actual data)
  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/laptop2.jpg',
      'name': 'HP Spectre',
      'price': '\$999'
    },
    {
      'image': 'assets/images/laptop3.jpeg',
      'name': 'Dell XPS 13',
      'price': '\$1,299'
    },
    {
      'image': 'assets/images/laptop4.jpeg',
      'name': 'Lenovo Yoga',
      'price': '\$899'
    },
    {
      'image': 'assets/images/laptop5.jpeg',
      'name': 'MacBook Pro',
      'price': '\$2,399'
    },
    {
      'image': 'assets/images/laptop6.jpeg',
      'name': 'Asus ZenBook',
      'price': '\$1,099'
    },
    // Add more product items here
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.primary,
                elevation: 0,
                flexibleSpace: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text(
                        "Discover",
                        style: TextStyle(
                          fontSize: FontSizes.headline1,
                          fontWeight: FontSizes.bold,
                          letterSpacing: -1,
                          color: AppColors.white,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartScreen()));
                          },
                          child: const Icon(Icons.shopping_cart))
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Field
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontSizes.regular,
                                fontSize: FontSizes.headline4,
                                letterSpacing: -1,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon:
                                    Icon(Icons.search, color: Colors.grey[600]),
                                onPressed: () {
                                  // Action when search icon is pressed
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Banner Image
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Get Your \nLaptops at \nAmazing Prices!",
                                          style: TextStyle(
                                            fontSize: FontSizes.headline2,
                                            fontWeight: FontSizes.bold,
                                            letterSpacing: -1,
                                            color: AppColors.white,
                                          ),
                                          maxLines: 3,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        flex: 1,
                                        child: Image(
                                            image: AssetImage(
                                          "assets/images/laptop11.jpeg",
                                        )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                      width: 130,
                                      height: 34,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Up to 10% discount !",
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: FontSizes.headline6,
                                            fontWeight: FontSizes.bold,
                                            letterSpacing: -1,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Category Chips
                          Row(
                            children: [
                              const Text(
                                "Category",
                                style: TextStyle(
                                  fontWeight: FontSizes.regular,
                                  fontSize: FontSizes.headline3,
                                  letterSpacing: -1,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: FontSizes.headline4,
                                    fontWeight: FontSizes.regular,
                                    color: AppColors.textColor,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 30.0,
                            runSpacing: 8.0,
                            children: List<Widget>.generate(
                              categories.length,
                              (index) {
                                return ChoiceChip(
                                  label: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: selectedCategory == index
                                          ? AppColors.white
                                          : AppColors.textColor,
                                    ),
                                  ),
                                  selected: selectedCategory == index,
                                  selectedColor: AppColors.primary,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: AppColors.textColor),
                                  ),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selectedCategory =
                                          selected ? index : selectedCategory;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Grid View of Products
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: Laptop(
                                  name: products[index]['name'] ?? 'Unknown',
                                  imagePath: products[index]['image'] ??
                                      'assets/default_image.png',
                                  price: products[index]['price'] ?? '1000',
                                  description: products[index]['description'] ??
                                      'No description available',
                                ),
                              );
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
