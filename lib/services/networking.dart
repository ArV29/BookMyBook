import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential uCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  if (uCredential.additionalUserInfo!.isNewUser) {
    CollectionReference usersData =
        FirebaseFirestore.instance.collection('users');
    await usersData.doc(uCredential.user!.uid).set({
      'name': uCredential.user!.displayName,
      'email': uCredential.user!.email,
      'ads': [],
    });
  }
  return uCredential;
}

Future signOut() async {
  await GoogleSignIn().signOut();
}

Future<List> getBooksForLocation({required location}) async {
  CollectionReference citiesData =
      FirebaseFirestore.instance.collection('cities');
  DocumentSnapshot? adsForCity = await citiesData.doc(location).get();
  Map<String, dynamic> data = adsForCity.data() as Map<String, dynamic>;
  return data['ads'];
}

Future<List> getBooksForUser({required location}) async {
  CollectionReference usersData =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot? user =
      await usersData.doc(FirebaseAuth.instance.currentUser!.uid).get();
  Map<String, dynamic> data = user.data() as Map<String, dynamic>;
  return data['ads'];
}

Future<Map> getAdInfo({required adId}) async {
  CollectionReference ads = FirebaseFirestore.instance.collection('ads');
  DocumentSnapshot? adInfo = await ads.doc(adId).get();
  Map<String, dynamic> data = adInfo.data() as Map<String, dynamic>;
  return data;
}

Future addAdvertisement(
    {required String title,
    required String owner,
    required String author,
    required String subject,
    required int age,
    required int publication,
    required int price,
    required int edition,
    required String city}) async {
  CollectionReference ads = FirebaseFirestore.instance.collection('ads');
  DocumentReference addInfo = await ads.add({
    'title': title,
    'owner': owner,
    'author': author,
    'subject': subject,
    'age': age,
    'publication': publication,
    'price': price,
    'edition': edition,
    'city': city,
  });

  String id = addInfo.id;
  CollectionReference citiesData =
      FirebaseFirestore.instance.collection('cities');
  DocumentSnapshot? adsForCity = await citiesData.doc(city).get();
  Map<String, dynamic> data = adsForCity.data() as Map<String, dynamic>;
  data['ads'].add(id);
  await citiesData.doc(city).set(data);

  print('owner: $owner');
  CollectionReference usersData =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot? user = await usersData.doc(owner).get();
  Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
  userData['ads'].add(id);
  await usersData.doc(owner).set(userData);
}

Future deleteAd({required String adId}) async {
  CollectionReference ads = FirebaseFirestore.instance.collection('ads');
  DocumentSnapshot? ad = await ads.doc(adId).get();
  Map data = ad.data() as Map<String, dynamic>;
  String owner = FirebaseAuth.instance.currentUser!.uid;
  String city = data['city'];
  await ads.doc(adId).delete();
  CollectionReference citiesData =
      FirebaseFirestore.instance.collection('cities');
  DocumentSnapshot? adsForCity = await citiesData.doc(city).get();
  data = adsForCity.data() as Map<String, dynamic>;
  data['ads'].remove(adId);
  await citiesData.doc(city).set(data);
  CollectionReference usersData =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot? user = await usersData.doc(owner).get();
  Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
  userData['ads'].remove(adId);
  await usersData.doc(owner).set(userData);
}
