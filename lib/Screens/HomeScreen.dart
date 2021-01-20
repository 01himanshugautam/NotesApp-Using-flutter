import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes/Screens/create.dart';
import 'package:my_notes/Services/phone_auth.dart';
import 'package:my_notes/Widgets/ProductCard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('notes');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // var h = MediaQuery.of(context).size.height;
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff121212),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    transport(Create());
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    auth.signOut();
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("My Notes"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: getRefresh,
        child: Container(
          child: FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      children: snapshot.data.docs.map((document) {
                        return ProductCard(
                          title: document.data()['title'],
                          body: document.data()['body'],
                          productId: document.id,
                        );
                      }).toList(),
                    ),
                  ],
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  transport(Widget n) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => n),
    );
  }
}
