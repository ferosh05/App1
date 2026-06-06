import 'package:flutter/material.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Model/shop_model.dart';
import 'package:pro/Provider/shop_provider.dart';
import 'package:pro/Shop/shop_dettail_screen.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShopProvider>(context, listen: false).fetchShops();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Shop List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Use Consumer to rebuild UI when data changes
      body: Consumer<ShopProvider>(
        builder: (context, shopProvider, child) {
          if (shopProvider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFF5F3)));
          }

          if (shopProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(shopProvider.errorMessage));
          }

          if (shopProvider.shops.isEmpty) {
            return const Center(child: Text("No shops found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: shopProvider.shops.length,
            itemBuilder: (context, index) {
              final shop = shopProvider.shops[index];
              return ShopItemCard(shop: shop); // Pass the shop data here
            },
          );
        },
      ),
    );
  }
}
class ShopItemCard extends StatelessWidget {
  final ShopModel shop; // Accept Shop model

  const ShopItemCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopDetailsScreen(shop: shop), // Passing data to details
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Images.applogo,
                
                width: 70,
                height: 70,
                
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[300],
                    child: const Icon(Icons.store, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    shop.name, // Real API Name
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "District: ${shop.district}", // Real API District
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    "Phone: ${shop.phoneNumber}", // Real API Phone
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}