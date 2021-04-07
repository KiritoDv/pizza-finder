import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizza_finder/local/db.dart';
import 'package:pizza_finder/widgets/network_image.dart';

class ProfileView extends StatelessWidget {

  final fb = AssetImage("assets/icons/main-icon.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Stack(
                      children: [
                        FutureBuilder(
                          future: ImageUtils.fetchImage(fb, LocalData.user.avatar),
                          builder: (context, snap) {
                            return Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)
                                ),
                                child: Image(
                                  width: snap.hasData ? MediaQuery.of(context).size.width : 32,
                                  height: snap.hasData ? MediaQuery.of(context).size.height : 32,
                                  fit: BoxFit.cover,
                                  image: snap.hasData ? snap.data : fb,
                                ),
                              ),
                            );
                          }
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            child: Icon(Icons.edit),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(bottom: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ),
                Center(
                  child: Container(
                    width: 200,                    
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)
                      ),
                    ),
                    child: Text("@ ${LocalData.user.username.replaceAll(RegExp(r'@'), '')}", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text("Personal information", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Name: ${LocalData.user.firstName} ${LocalData.user.lastName}", style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Gender: ${LocalData.user.gender.substring(0, 1).toUpperCase()}${LocalData.user.gender.substring(1)}", style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Born ${DateFormat.yMMMMd().format(DateTime.parse(LocalData.user.birthday))}", style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Change password", style: TextStyle(fontSize: 11, color: Colors.white)),
                          SizedBox(width: 5),
                          Icon(Icons.edit, size: 16)
                        ],
                      )
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text("Contact information", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Email: ${LocalData.user.email}", style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Phone: 5512345678", style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text("About me", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Favourite Pizza: Pepperoni", style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                    Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text("Team: Pineapple = Bad", style: TextStyle(fontSize: 11, color: Colors.white)),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white10),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 25, vertical: 5)),
                      backgroundColor: MaterialStateProperty.all(Colors.black)
                    ),
                    onPressed: () {
                      LocalData.db.removeUser();
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: Text("Logout", style: TextStyle(color: Colors.white))
                  ),
                ),
                SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }

}