import 'package:book_my_book/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:book_my_book/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class AddAd extends StatefulWidget {
  static const String id = 'add_ad';
  const AddAd({Key? key}) : super(key: key);

  @override
  _AddAdState createState() => _AddAdState();
}

class _AddAdState extends State<AddAd> {
  String owner = FirebaseAuth.instance.currentUser!.uid,
      subject = '',
      title = '',
      city = 'chandigarh',
      author = '';
  int price = -1, age = -1, edition = -1, publication = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Advertisement',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(color: kDarkBlue, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: kBackgroundBlue,
        foregroundColor: kDarkBlue,
        elevation: 0,
      ),
      backgroundColor: kBackgroundBlue,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Enter title of the book',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    author = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Enter name of the author',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    subject = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Enter subject',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    price = int.parse(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Enter price of the book',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    edition = int.parse(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Enter edition ',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    publication = int.parse(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Enter year of publication',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    age = int.parse(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'For how much time have you owned the book',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          MaterialButton(
            onPressed: () async {
              if (title == '' ||
                  author == '' '' ||
                  subject == '' ||
                  age == -1 ||
                  publication == -1 ||
                  price == -1 ||
                  edition == -1) {
                Fluttertoast.showToast(
                    msg: "Please fill in all the details!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
              } else if (age > 15 || publication < 2005) {
                Fluttertoast.showToast(
                    msg: "Book Too Old!\nPlease Try to Sell another book",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
              } else {
                await addAdvertisement(
                  title: title,
                  owner: owner,
                  author: author,
                  subject: subject,
                  age: age,
                  publication: publication,
                  price: price,
                  edition: edition,
                  city: city,
                );
                Fluttertoast.showToast(
                    msg: "Successfully Added Advertisement",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);

                Navigator.pushReplacementNamed(context, Homepage.id);
              }
            },
            child: Text(
              'Add Advertisement',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            color: kYellow,
          ),
        ],
      ),
    );
  }
}
