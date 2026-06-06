import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Model/shop_model.dart';

class ShopDetailsScreen extends StatefulWidget {
  final ShopModel shop; // 2. Add a final Shop variable

  // 3. Update the constructor to require the shop data
  const ShopDetailsScreen({super.key, required this.shop});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Access data using widget.shop
    final shop = widget.shop;

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        backgroundColor: AppColors.bgcolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context), // Added pop action
        ),
        title: const Text(
          "Shop Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Profile Section ---
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    Images.applogo,
                    width: 60,
                    height: 60,
               
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.store),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name, // API SHOP NAME
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ID: ${shop.id}", // API ID
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),

            const SizedBox(height: 20),

            // --- 3. Description Text ---
            const Text(
              "Professional shop service providing high-quality assistance. This shop is located in a prime area and serves customers with dedicated staff and verified background. Open for regular visits.",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF555555),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // --- 4. Contact Details Card ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildContactRow(
                    icon: AppIcons.call,
                    label: "Phone Number",
                    value: shop.phoneNumber, // API PHONE NUMBER
                  ),
                  const SizedBox(height: 20),
                  _buildContactRow(
                    icon: AppIcons.email,
                    label: "State",
                    value: shop.state, // API STATE
                  ),
                  const SizedBox(height: 20),
                  _buildContactRow(
                    icon: AppIcons.loc,
                    label: "Address (District)",
                    value: shop.district, // API DISTRICT
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({required String icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFFFFECE8), 
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            icon, scale: 4.5,
            color: const Color(0xFFD34032), 
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}