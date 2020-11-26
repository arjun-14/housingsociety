import 'package:flutter/material.dart';
import 'screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// void main() async {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialization,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           print('error');
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MaterialApp(
//             theme: ThemeData.dark().copyWith(
//               primaryColor: Color(0xFF0A0E21),
//               scaffoldBackgroundColor: Color(0xFF0A0E21),
//             ),
//             home: Wrapper(),
//           );
//         }
//         return SpinKitWave();
//       },
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: Wrapper(),
    );
  }
}
