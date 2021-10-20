import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class IRobotXFirebaseUser {
  IRobotXFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

IRobotXFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<IRobotXFirebaseUser> iRobotXFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<IRobotXFirebaseUser>(
        (user) => currentUser = IRobotXFirebaseUser(user));
