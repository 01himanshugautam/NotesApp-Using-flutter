// import 'package:flutter/material.dart';
// import 'package:my_notes/Services/CloudFirestore.dart';

// class HomeData extends StatefulWidget {
//   HomeData({Key key}) : super(key: key);

//   @override
//   _HomeDataState createState() => _HomeDataState();
// }

// class _HomeDataState extends State<HomeData> {
//   FirestoreServices _firebaseFirestore = FirestoreServices();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 100,
//         child: Card(
//           elevation: 0,
//           color: Colors.grey,
//           child: ListView(
//             children: snapshot.data.docs.map((document) {
//               return ListTile(
//                 title: Text(
//                   "${document.data()['title']}",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 subtitle: Text("${document.data()['body']}",
//                     style: TextStyle(color: Colors.white)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
