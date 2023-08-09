import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modals/device_profile.dart';
import 'package:untitled/modals/user_modal.dart';
import 'package:untitled/providers/user_provider.dart';
import 'package:untitled/utils/constants.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<UserProvider>(context);
    TextEditingController latitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    TextEditingController themeColorController = TextEditingController();
    TextEditingController fontSizeController = TextEditingController();

    void addLocation() {
      try {
        if (double.tryParse(fontSizeController.text) == null ||
            themeColorController.text.isEmpty) {
          Fluttertoast.showToast(
              msg: "Invalid Value for Color/Font Size",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

        myData.addingUserProfile(UserModal(
            latitude: double.parse(latitudeController.text),
            longitude: double.parse(longitudeController.text),
            deviceProfile: DeviceProfile(
                themeColorController.text, fontSizeController.text)));

        Fluttertoast.showToast(
            msg: "Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } catch (error) {
        Fluttertoast.showToast(
            msg: "Something Went Wrong!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: AppConstants.primaryColor,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            final latitudeMatcher =
                RegExp(r'^([-+]?\d{1,2}([.]\d+)?),\s*([-+]?\d{1,3}([.]\d+)?)$');

            if (double.tryParse(latitudeController.text) == null ||
                double.tryParse(longitudeController.text) == null) {
              Fluttertoast.showToast(
                  msg: "Invalid Value for Latitude/Longitude",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            if (!latitudeMatcher.hasMatch(
                "${latitudeController.text},${longitudeController.text}")) {
              Fluttertoast.showToast(
                  msg: "Invalid Value for Latitude/Longitude",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return;
            }

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Device Profile'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: themeColorController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Theme Color"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: fontSizeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Font Size"),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        onPressed: addLocation,
                        child: const Text('Add'),
                      ),
                    ],
                  );
                });
          },
          child: const Center(
            child: Text('Add'),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextFormField(
            controller: latitudeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter Latitude"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: longitudeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter Longitude"),
          )
        ],
      ),
    );
  }
}
