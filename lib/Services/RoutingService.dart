import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Screens/HomeScreen.dart';
import 'package:my_notes/Screens/login_screen.dart';

class RoutingBasedOnAuth {
  checkAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null)
              return HomeScreen();
            else
              return LogInScreen();
          }

          return CircularProgressIndicator();
        });
  }
}
