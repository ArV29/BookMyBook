import 'package:book_my_book/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../services/networking.dart';

class DeleteAd extends StatefulWidget {
  static const String id = 'delete_ad';
  const DeleteAd({Key? key}) : super(key: key);

  @override
  _DeleteAdState createState() => _DeleteAdState();
}

class _DeleteAdState extends State<DeleteAd> {
  List<Widget> cards = [Text('Loading...')];
  Future<List<Widget>> generateBookInfoCards() async {
    List ads = await getBooksForUser(location: 'chandigarh');
    if (ads.length == 0) {
      return [Text('You haven\'t posted any ads till now')];
    }
    List<Widget> cards = [];
    for (String adId in ads) {
      Map info = await getAdInfo(adId: adId);
      Widget card = GestureDetector(
        onTap: () {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Delete Advertisement",
            desc: "Delete Advertisement for ${info['title']}",
            buttons: [
              DialogButton(
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  onPressed: () async {
                    await deleteAd(adId: adId);
                    Fluttertoast.showToast(
                        msg: "Successfully Removed Advertisement",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                    Navigator.pop(context);
                    loadData();
                  },
                  color: kBackgroundBlue),
              DialogButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                color: kBackgroundBlue,
              ),
            ],
          ).show();
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
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Advertisements',
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
              onPressed: () async {
                var c = await generateBookInfoCards();
                setState(() {
                  cards = c;
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: kBackgroundBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: cards,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
