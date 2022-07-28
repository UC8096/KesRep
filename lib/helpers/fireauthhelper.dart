part of 'helpers.dart';

class FireAuthHelper {
  static Future<FirebaseApp> initializeFirebase(
      {required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    bool _isExist = true;

    if (user != null) {
      _isExist = await PlayerHelper.playerChecker();

      if (!_isExist) {
        PlayerHelper.addPlayer();
      }

      Future.delayed(const Duration(seconds: 5)).whenComplete(
          () => Navigator.pushReplacementNamed(context, '/homepage'));
    } else {
      Future.delayed(const Duration(seconds: 5)).whenComplete(
          () => Navigator.pushReplacementNamed(context, '/authpage'));
    }

    return firebaseApp;
  }

  // For registering a new user
  static Future<User?> registerUsingEmailPassword({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        modalErrorAuthWidget(
            context: context,
            description: 'The password provided is too weak.',
            onTapRed: () => Navigator.pop(context));
      } else if (e.code == 'email-already-in-use') {
        modalErrorAuthWidget(
            context: context,
            description: 'The account already exists for that email.',
            onTapRed: () => Navigator.pop(context));
      }
    } catch (e) {
      modalErrorAuthWidget(
          context: context,
          description: e.toString(),
          onTapRed: () => Navigator.pop(context));
    }

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/loadingpage');
    }

    return user;
  }

  // For signing in an user (have already registered)
  static Future<User?> signInUsingEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        modalErrorAuthWidget(
            context: context,
            description: 'No user found for that email.',
            onTapRed: () => Navigator.pop(context));
      } else if (e.code == 'wrong-password') {
        modalErrorAuthWidget(
            context: context,
            description: 'Wrong password provided.',
            onTapRed: () => Navigator.pop(context));
      } else {
        modalErrorAuthWidget(
            context: context,
            description: e.toString(),
            onTapRed: () => Navigator.pop(context));
      }
    }

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/loadingpage');
    }

    return user;
  }

  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final _googleSignIn = GoogleSignIn();

    User? user;

    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    user = auth.currentUser;

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static Future logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    await auth.signOut();
    await googleSignIn.signOut();
  }
}
