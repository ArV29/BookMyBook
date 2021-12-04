import 'package:book_my_book/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/miscellaneous.dart';
import 'homepage.dart';

class CityChooser extends StatefulWidget {
  static const String id = 'city_chooser';
  const CityChooser({Key? key}) : super(key: key);

  @override
  _CityChooserState createState() => _CityChooserState();
}

class _CityChooserState extends State<CityChooser> {
  Widget pickCityImage({required String cityName}) {
    Widget image = Image(
      image: AssetImage('assets/images/cityImages/$cityName.webp'),
      width: 84,
      height: 84,
    );
    Widget imageButton = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              image,
              Text(cityName.capitalize()),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, Homepage.id);
      },
    );
    return imageButton;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose your City',
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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pickCityImage(cityName: 'chandigarh'),
              ],
            ),
            Center(
              child: Text('More Cities to be Added!'),
            ),
          ],
        ),
      ),
    );
  }
}
