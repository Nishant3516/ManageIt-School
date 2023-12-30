import 'package:flutter/material.dart';

class SocialAuth extends StatefulWidget {
  final void Function() onGoogleSignInComplete;

  const SocialAuth({
    super.key,
    required this.onGoogleSignInComplete,
  });

  @override
  State<SocialAuth> createState() => _SocialAuthState();
}

class _SocialAuthState extends State<SocialAuth> {
  @override
  Widget build(BuildContext context) {
//     Future<void> signInWithGoogle() async {
//       // Create an instance of the FirebaseAuth and Google Sign in
//       FirebaseAuth auth = FirebaseAuth.instance;
//       final GoogleSignIn googleSignIn = GoogleSignIn();

//       // Triger the authentication flow
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//       if (googleUser == null) {
//         return;
//       }
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

// // Create a new Credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign In with the credentials
//       final UserCredential userCredential =
//           await auth.signInWithCredential(credential);
//       widget.onGoogleSignInComplete();
//     }

    return GestureDetector(
      onTap: () async {
        // await signInWithGoogle();
        // NavigatorWidget().screenPushReplacement(
        //     context,
        //     Scaffold(
        //       body: HomeScreen(),
        //       backgroundColor: Colors.black,
        //     ));
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1)),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/images/google-logo.png',
          ),
        ),
      ),
    );
  }
}
