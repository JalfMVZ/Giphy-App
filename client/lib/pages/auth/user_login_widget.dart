// import 'package:flutter/material.dart';
// import 'package:flutter_bloc_tutorial/home/view/home_page.dart';
// import 'package:flutter_bloc_tutorial/utils/auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserLoginWidget extends StatefulWidget {
//   static const String routeName = 'WidgetLogin';

//   const UserLoginWidget({Key? key}) : super(key: key);

//   @override
//   _UserLoginWidgetState createState() => _UserLoginWidgetState();
// }

// class _UserLoginWidgetState extends State<UserLoginWidget> {
//   final AuthService _authService = AuthService();

//   @override
//   void initState() {
//     super.initState();
//     _autoSignIn();
//   }

//   Future<void> _autoSignIn() async {
//     final String? email = await _getStoredEmail();
//     if (email != null) {
//       final String? password = await _getStoredPassword();
//       if (password != null) {
//         bool success =
//             await _authService.signInWithEmailAndPassword(email, password);
//         if (success) {
//           Navigator.pushReplacementNamed(context, HomePage.routeName);
//           return;
//         }
//       }
//     }
//   }

//   Future<String?> _getStoredEmail() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('user_email');
//   }

//   Future<String?> _getStoredPassword() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('user_password');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'Bienvenido a Gyphy App',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               InkWell(
//                 onTap: () async {
//                   final String? email = await _getStoredEmail();
//                   if (email != null) {
//                     final String? password = await _getStoredPassword();
//                     if (password != null) {
//                       bool success =
//                           await _authService.signInWithEmailAndPassword(
//                         email,
//                         password,
//                       );
//                       if (success) {
//                         Navigator.pushReplacementNamed(
//                           context,
//                           HomePage.routeName,
//                         );
//                       }
//                     }
//                   }
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: const Text(
//                     'Iniciar Sesión',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
