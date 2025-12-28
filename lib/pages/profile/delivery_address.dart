import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final houseNoController = TextEditingController();
  final houseNameController = TextEditingController();
  final streetController = TextEditingController();
  final districtController = TextEditingController();
  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();

  Future<void> saveAddress() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('addresses').doc(uid).set({
      "name": nameController.text,
      "phone": phoneController.text,
      "houseNumber": houseNoController.text,
      "houseName": houseNameController.text,
      "street": streetController.text,
      "district": districtController.text,
      "pincode": pincodeController.text,
      "landmark": landmarkController.text,
      "updatedAt": Timestamp.now(),
    });

    // SAVE DATAS
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "name": nameController.text,
      "phone": phoneController.text,
    }, SetOptions(merge: true));

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Address",
          style: TextStyle(color: Color(0xffffffff)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildField("Name", nameController),
                buildField(
                  "Phone Number",
                  phoneController,
                  type: TextInputType.phone,
                ),
                buildField("House Number", houseNoController),
                buildField("House Name", houseNameController),
                buildField("Street", streetController),
                buildField("District", districtController),
                buildField(
                  "Pincode",
                  pincodeController,
                  type: TextInputType.number,
                ),
                buildField("Landmark", landmarkController),
                const SizedBox( height: 20),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveAddress();
                      }
                    },
                    child: const Text("Save Address", style: TextStyle(color: Color(0xFF00C569))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
