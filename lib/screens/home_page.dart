import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modals/device_profile.dart';
import 'package:untitled/modals/user_modal.dart';
import 'package:untitled/providers/user_provider.dart';
import 'package:untitled/screens/add_user.dart';
import 'package:untitled/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Profile List", style: TextStyle(color: Colors.white)),
        backgroundColor: AppConstants.primaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: myData.retrieveUserProfiles(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModal>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.settings),
                          ),
                          title: Text(
                              "Location: (${snapshot.data![index].latitude}, ${snapshot.data![index].longitude})"),
                          subtitle: Text(
                              "Text Size: ${snapshot.data![index].deviceProfile?.textSize}, Theme Color: ${snapshot.data![index].deviceProfile?.themeColor}"));
                    },
                  )
                : const Center(
                    child: Text("No Data"),
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const AddUser()));
        },
      ),
    );
  }
}
