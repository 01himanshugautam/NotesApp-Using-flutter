import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  Create({Key key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference productsRef =
        FirebaseFirestore.instance.collection('notes');

    TextEditingController title = new TextEditingController();
    TextEditingController body = new TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xff121212),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: 50,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Map<String, dynamic> data = {
                      "title": title.text,
                      "body": body.text
                    };
                    productsRef.add(data);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Text(
                        "Save",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                maxLines: 2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Title'),
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
                  maxLines: 18,
                  controller: body,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Description'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
