import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Provider/worker_edit_profile_provider.dart';
import 'package:provider/provider.dart';

class WokereditProfileScreen extends StatefulWidget {
  final String? currentName;
  final String? currentPhone;
  final String? currentEmail;
  final String? currentAddress;
  final String? currentGender;
  final String? currentSubscriptionExpiry; // Added
  final String customerId;
  final String currentImage;

  const WokereditProfileScreen({
    super.key,
    this.currentName,
    this.currentPhone,
    this.currentEmail,
    this.currentAddress,
    this.currentGender,
    this.currentSubscriptionExpiry, // Added
    required this.customerId,
    required this.currentImage,
  });

  @override
  State<WokereditProfileScreen> createState() => _WokereditProfileScreenState();
}

class _WokereditProfileScreenState extends State<WokereditProfileScreen> {
  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _expiryController; // Added

  String? _selectedGender;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName ?? '');
    _phoneController = TextEditingController(text: widget.currentPhone ?? '');
    _emailController = TextEditingController(text: widget.currentEmail ?? '');
    _addressController = TextEditingController(text: widget.currentAddress ?? '');
    _expiryController = TextEditingController(text: widget.currentSubscriptionExpiry ?? ''); // Added
    _selectedGender = widget.currentGender ?? 'Male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _expiryController.dispose(); // Added
    super.dispose();
  }

  // Function to pick Date for Subscription Expiry
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    // Try to parse existing date if valid
    try {
      if (_expiryController.text.isNotEmpty) {
        initialDate = DateTime.parse(_expiryController.text);
      }
    } catch (e) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // _expiryController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Function to Pick Image
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkerEditProfileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.bgcolor,
          appBar: AppBar(
            backgroundColor: AppColors.bgcolor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 15),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Profile Image Section ---
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!) as ImageProvider
                            : (widget.currentImage.isNotEmpty
                                ? NetworkImage(widget.currentImage)
                                : AssetImage(Images.profileimage)) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            backgroundColor: AppColors.color1,
                            radius: 23,
                            child: Image.asset(AppIcons.edit_profile, scale: 3.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- Name ---
                const Text('Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration('Full Name'),
                ),
                const SizedBox(height: 20),

                // --- Gender ---
                const Text('Gender', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Row(
                  children: <Widget>[
                    _buildRadioTile('Male'),
                    _buildRadioTile('Female'),
                    _buildRadioTile('Other'),
                  ],
                ),
                const SizedBox(height: 20),

                // --- Phone ---
                const Text('Phone Number', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration('Phone Number'),
                ),
                const SizedBox(height: 20),

                // --- Email ---
                const Text('Email ID', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration('Email ID'),
                ),
                const SizedBox(height: 20),

                // --- Address ---
                const Text('Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _addressController,
                  decoration: _inputDecoration('Address'),
                ),
                const SizedBox(height: 20),

                // --- Subscription Expiry ---
                const Text('Subscription Expiry', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _expiryController,
                  readOnly: true, // User selects from calendar
                  onTap: () => _selectDate(context),
                  decoration: _inputDecoration('YYYY-MM-DD').copyWith(
                    suffixIcon: const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Update Button ---
                Center(
                  child: InkWell(
                    onTap: provider.isLoading
                        ? null
                        : () {
                            if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Name and Phone are required")),
                              );
                              return;
                            }

                            provider.updateWorkerProfile(
                              context: context,
                              workerId: widget.customerId,
                              name: _nameController.text,
                              gender: _selectedGender ?? 'Male',
                              phoneNumber: _phoneController.text,
                              emailId: _emailController.text,
                              address: _addressController.text,
                              subscriptionExpiry: _expiryController.text, // Passed to provider
                              avatarImage: _selectedImage,
                            );
                          },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [AppColors.color1,AppColors.color2]),
                      ),
                      child: Center(
                        child: provider.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRadioTile(String value) {
    return Expanded(
      child: RadioListTile<String>(
        activeColor: AppColors.color1,
        title: Text(value, style: const TextStyle(fontSize: 13)),
        value: value,
        groupValue: _selectedGender,
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
        contentPadding: EdgeInsets.zero,
        dense: true,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}