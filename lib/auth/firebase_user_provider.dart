import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class KronoxFirebaseUser {
  KronoxFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

KronoxFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<KronoxFirebaseUser> kronoxFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<KronoxFirebaseUser>((user) => currentUser = KronoxFirebaseUser(user));
