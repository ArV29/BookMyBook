import 'package:book_my_book/screens/chooseCity.dart';
import 'package:book_my_book/screens/login_screen.dart';
import 'package:book_my_book/screens/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../services/networking.dart';
import 'add_ad.dart';
import 'delete_ad.dart';

class Homepage extends StatefulWidget {
  static const String id = 'homepage';
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String name = '', email = '', location = 'Chandigarh';
  List<Widget> cards = [Text('Loading...')];

  Widget UserImage() {
    if (FirebaseAuth.instance.currentUser!.photoURL != null) {
      return CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL.toString(),
          ));
    } else {
      return Icon(
        Icons.account_circle_outlined,
        size: 32,
      );
    }
  }

  Future<List<Widget>> generateBookInfoCards() async {
    List ads = await getBooksForLocation(location: 'chandigarh');
    if (ads.length == 0) {
      return [Text('Sorry\nNo Books Currently Available')];
    }
    List<Widget> cards = [];
    for (String adId in ads) {
      print(adId);
      Map info = await getAdInfo(adId: adId);
      print(info);
      Widget card = GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.id, arguments: adId);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kLightBlue, width: 2),
            color: kLightYellow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info['title'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: kDarkBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      info['author'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: kDarkBlue, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹' + info['price'].toString(),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(color: kDarkBlue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      cards.add(card);
      cards.add(SizedBox(height: 16.0));
    }
    return cards;
  }

  Future loadData() async {
    var c = await generateBookInfoCards();
    setState(() {
      cards = c;
      print(cards);
    });
  }

  @override
  void initState() {
    name =
        email = FirebaseAuth.instance.currentUser!.displayName!.split(" ")[0];
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await signOut();
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,
                    ModalRoute.withName(LoginScreen.id));
              }),
        ),
        title: Text(
          'Homepage',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: kDarkBlue, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: kBackgroundBlue,
        foregroundColor: kDarkBlue,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.place),
              onPressed: () async {
                await signOut();
                Navigator.pushNamedAndRemoveUntil(context, CityChooser.id,
                    ModalRoute.withName(CityChooser.id));
              }),
        ],
      ),
      backgroundColor: kBackgroundBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello $name',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: kDarkBlue, fontSize: 32),
                  ),
                ),
                GestureDetector(
                  child: UserImage(),
                  onTap: () {
                    Navigator.pushNamed(context, DeleteAd.id);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              color: kDarkBlue,
              height: 2,
              width: double.maxFinite,
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Books in $location',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(color: kDarkBlue, fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var c = await generateBookInfoCards();
                    setState(() {
                      cards = c;
                    });
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            Container(
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: cards,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddAd.id);
        },
      ),
    );
  }
}
