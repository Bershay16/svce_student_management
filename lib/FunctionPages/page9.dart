import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

//About Our College
class Page9 extends StatelessWidget {
  const Page9({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "",
      "",
      "",
      "",
      "",
      "",
    ];

    final List<String> imagePaths = [
    'assets/images/rank.png',
    'assets/images/faculty.png',
    'assets/images/abroad.png',
    'assets/images/lab.png',
    'assets/images/naac.png',
    'assets/images/companies.png'
    ];

    final List<Widget> images = imagePaths.map((imagePath) {
      return Opacity(
        opacity: 1, 
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(child: Text('About SVCE')),
      ),
      body: Container(
        color: Colors.blue[50],
        child: SafeArea(
          child: Column(
            
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Why SVCE?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: VerticalCardPager(
                    titles: titles, 
                    images: images,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    onPageChanged: (page) {}, 
                    onSelectedItem: (index) {}, 
                    initialPage: 0, 
                    align: ALIGN.CENTER, 
                    physics: const ClampingScrollPhysics(), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
