// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:mainapp/chat_screen/chat_list_screen.dart';
// import 'package:mainapp/login_page/login_screen.dart';
// import 'package:mainapp/login_page/my_text_field.dart';
// import 'package:mainapp/signup_screen/signup_screen.dart';

// // class BeforeSignUpPage extends StatefulWidget {
// //   const BeforeSignUpPage({super.key});

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _BeforeSignUpPageState createState() => _BeforeSignUpPageState();
// // }

// // class _BeforeSignUpPageState extends State<BeforeSignUpPage> {
// //   TextEditingController phoneNumberController = TextEditingController();
// //   TextEditingController verificationCodeController = TextEditingController();

// //   String verificationId = '';
// //   bool codeSent = false;

// //   void signupWithPhoneNumber() async {
// //     final FirebaseAuth _auth = FirebaseAuth.instance;

// //     if (codeSent) {
// //       try {
// //         final AuthCredential credential = PhoneAuthProvider.credential(
// //           verificationId: verificationId,
// //           smsCode: verificationCodeController.text,
// //         );

// //         final UserCredential userCredential =
// //             await _auth.signInWithCredential(credential);

// //         if (userCredential.user != null) {
// //           // User signed in successfully
// //           // ignore: use_build_context_synchronously
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (_) => const SignUpPage()),
// //           );
// //         } else {
// //           displayMessage("Failed to sign in.");
// //         }
// //       } catch (e) {
// //         displayMessage("Invalid verification code.");
// //       }
// //     } else {
// //       try {
// //         await _auth.verifyPhoneNumber(
// //           phoneNumber: phoneNumberController.text,
// //           verificationCompleted: (PhoneAuthCredential credential) async {
// //             final UserCredential userCredential =
// //                 await _auth.signInWithCredential(credential);

// //             if (userCredential.user != null) {
// //               // User signed in successfully
// //               // ignore: use_build_context_synchronously
// //               Navigator.pushReplacement(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const ChatListScreen()),
// //               );
// //             }
// //           },
// //           verificationFailed: (FirebaseAuthException e) {
// //             displayMessage("Failed to verify phone number.");
// //           },
// //           codeSent: (String verificationId, int? resendToken) {
// //             setState(() {
// //               this.verificationId = verificationId;
// //               codeSent = true;
// //             });
// //           },
// //           codeAutoRetrievalTimeout: (String verificationId) {},
// //         );
// //       } catch (e) {
// //         displayMessage("Failed to send verification code.");
// //       }
// //     }
// //   }

// //   void displayMessage(String message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text(message),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: Center(
// //           child: SingleChildScrollView(
// //             padding: const EdgeInsets.all(30),
// //             child: Column(
// //               children: [
// //                 Image.asset(
// //                   'assets/images/logo.png',
// //                   height: 120,
// //                 ),
// //                 const Padding(
// //                   padding: EdgeInsets.only(top: 30, bottom: 70),
// //                   child: Text(
// //                     "Rapid Technology",
// //                     style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //                 MyTextField(
// //                   hint: "Phone Number",
// //                   controller: phoneNumberController,
// //                   inputType: TextInputType.emailAddress,
// //                   isPassword: false,
// //                 ),
// //                 MyTextField(
// //                   hint: "Verification code",
// //                   controller: verificationCodeController,
// //                   inputType: TextInputType.text,
// //                   isPassword: true,
// //                 ),
// //                 SizedBox(
// //                   width: double.infinity,
// //                   height: 50,
// //                   child: MaterialButton(
// //                       color: Colors.green[700],
// //                       onPressed: signupWithPhoneNumber,
// //                       child: const Text(
// //                         "SignUp",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 18,
// //                         ),
// //                       )),
// //                 ),
// //                 const SizedBox(
// //                   height: 80,
// //                 ),
// //                 GestureDetector(
// //                   onTap: () {
// //                     Navigator.of(context).push(
// //                         MaterialPageRoute(builder: (_) => const LoginPage()));
// //                   },
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       const Text(
// //                         "Already have an account? ",
// //                         style: TextStyle(
// //                           color: Colors.black,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       Text(
// //                         "Login",
// //                         style: TextStyle(
// //                           color: Colors.green[700],
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class BeforeSignUpPage extends StatefulWidget {
//   const BeforeSignUpPage({super.key});

//   @override
//   BeforeSignUpPageState createState() => BeforeSignUpPageState();
// }

// class BeforeSignUpPageState extends State<BeforeSignUpPage> {
//   TextEditingController phoneNumberController = TextEditingController();

//   void sendVerificationCode() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumberController.text,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           final UserCredential userCredential =
//               await _auth.signInWithCredential(credential);

//           if (userCredential.user != null) {
//             // User signed in successfully
//             // ignore: use_build_context_synchronously
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const BeforeSignUpPage()),
//             );
//           }
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           displayMessage("Failed to verify phone number.");
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (_) =>
//                     VerificationCodeScreen(verificationId: verificationId)),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       displayMessage("Failed to send verification code.");
//     }
//   }

//   void displayMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(message),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/logo.png',
//                   height: 120,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(top: 30, bottom: 70),
//                   child: Text(
//                     "Rapid Technology",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 MyTextField(
//                   hint: "Phone Number",
//                   controller: phoneNumberController,
//                   inputType: TextInputType.phone,
//                   isPassword: false,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: MaterialButton(
//                     color: Colors.green[700],
//                     onPressed: sendVerificationCode,
//                     child: const Text(
//                       "Send Verification Code",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 80,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(builder: (_) => const LoginPage()),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Already have an account? ",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.green[700],
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class VerificationCodeScreen extends StatefulWidget {
//   final String verificationId;

//   const VerificationCodeScreen({super.key, required this.verificationId});

//   @override
//   VerificationCodeScreenState createState() => VerificationCodeScreenState();
// }

// class VerificationCodeScreenState extends State<VerificationCodeScreen> {
//   TextEditingController verificationCodeController = TextEditingController();

//   void verifyCode() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: verificationCodeController.text,
//       );

//       final UserCredential userCredential =
//           await _auth.signInWithCredential(credential);

//       if (userCredential.user != null) {
//         // User signed in successfully
//         // ignore: use_build_context_synchronously
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const SignUpPage()),
//         );
//       } else {
//         displayMessage("Failed to sign in.");
//       }
//     } catch (e) {
//       displayMessage("Invalid verification code.");
//     }
//   }

//   void displayMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(message),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/logo.png',
//                   height: 120,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(top: 30, bottom: 70),
//                   child: Text(
//                     "Rapid Technology",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 MyTextField(
//                   hint: "Verification Code",
//                   controller: verificationCodeController,
//                   inputType: TextInputType.number,
//                   isPassword: true,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: MaterialButton(
//                     color: Colors.green[700],
//                     onPressed: verifyCode,
//                     child: const Text(
//                       "Verify Code",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 80,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(builder: (_) => const LoginPage()),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Already have an account? ",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.green[700],
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
