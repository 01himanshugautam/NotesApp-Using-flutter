import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Services/CloudFirestore.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirestoreServices _firebaseFirestore = FirestoreServices();
  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference productsRef =
        FirebaseFirestore.instance.collection('notes');

    TextEditingController title = new TextEditingController();

    TextEditingController body = new TextEditingController();

    return RefreshIndicator(
      onRefresh: getRefresh,
      child: Scaffold(
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
                      Map<String, dynamic> data = {
                        "title": title.text,
                        "body": body.text
                      };
                      productsRef.doc(widget.productId).set(data);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                        ),
                        child: Text(
                          "Update",
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
                      DocumentReference documentReference = FirebaseFirestore
                          .instance
                          .collection('notes')
                          .doc(widget.productId);
                      documentReference.delete().whenComplete(
                          () => print("${widget.productId} deleted"));
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: Text(
                          "Delete",
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
          title: Text("Update"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future:
                  _firebaseFirestore.productsRef.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  final Map<String, dynamic> documentData =
                      snapshot.data.data();

                  title..text = '${documentData['title']}';
                  body..text = '${documentData['title']}';
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9),
                                ),
                                color: Color(0xa1ffffff),
                              ),
                              child: TextField(
                                controller: title,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(9),
                                  ),
                                  color: Color(0xa1ffffff),
                                ),
                                child: TextField(
                                  maxLines: 15,
                                  controller: body,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
          ],
        ),
      ),
    );
  }
}
