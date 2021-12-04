import 'package:book_my_book/services/networking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';

class ProductDetails extends StatefulWidget {
  static const String id = 'product_details';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String adId;
  Map info = {
    'title': '',
    'owner': '',
    'author': '',
    'subject': '',
    'age': '',
    'publication': '',
    'price': '',
    'edition': '',
    'city': '',
  };
  String email = '';
  Future setData() async {
    Map data = await getAdInfo(adId: adId);
    setState(() {
      info = data;
      email = FirebaseAuth.instance.currentUser!.email!;
    });
  }

  String editionSuffix() {
    if (info['edition'] == '1') {
      return 'st';
    } else if (info['edition'] == 2) {
      return 'nd';
    } else if (info['edition'] == 3) {
      return 'rd';
    } else {
      return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    adId = ModalRoute.of(context)!.settings.arguments as String;
    setData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kYellow,
        child: Icon(Icons.chat),
        onPressed: () {
          Alert(
            context: context,
            title: "Contact",
            desc: "The owner of the book can be contacted at: $email",
            buttons: [
              DialogButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: kDarkBlue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
            ],
          ).show();
        },
      ),
      appBar: AppBar(
        title: Text(
          'Book Info',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: kDarkBlue, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: kBackgroundBlue,
        foregroundColor: kDarkBlue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kLightBlue, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      info['title'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: kDarkBlue, fontSize: 48),
                      ),
                    ),
                  ),
                  Text(
                    'by: ${info['author']}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: kLightBlue, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kLightBlue, width: 2),
                  color: kBackgroundBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹' + info['price'].toString(),
                            style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: kDarkBlue, fontSize: 22),
                            ),
                          ),
                          SizedBox(width: 32.0),
                          Container(width: 2, height: 24, color: kLightYellow),
                          SizedBox(width: 32.0),
                          Text(
                            info['subject'].toString(),
                            style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: kDarkBlue, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        'Edition: ${info['edition']}' + editionSuffix(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: kDarkBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Year Of Publication: ${info['publication'].toString()}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: kDarkBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Age of the Book: ${info['age'].toString()} years',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: kDarkBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Location: ${info['city'].toString().toUpperCase()}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: kDarkBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
