import 'package:bookingo/component/ImageView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Home.dart';
import '../chatbot/chatbot.dart';
import 'edit_profile.dart';
import '../../sharedPreferences/sharedPreferences.dart';



class AboutHospital extends StatefulWidget {
  const AboutHospital({Key? key}) : super(key: key);

  @override
  State<AboutHospital> createState() => _AboutHospitalState();
}

class _AboutHospitalState extends State<AboutHospital> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: _buildappbar(),
          ),
          body: SingleChildScrollView(
            child:
            _buildbody(),
          ),
          bottomNavigationBar: BottomNavigationBar(context),
        )
    );
  }
}

class _buildappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          padding: EdgeInsets.only(left: 10, top: 20, right: 0, bottom: 20),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        child: Container(alignment: Alignment.bottomCenter),
        decoration: BoxDecoration(
            color: HexColor('#1C81AB'),
            borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
      ),
      title: Container(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          sharedPreferences.getUser('lang') == 'en' ? "About Hospital" : "عن المستشفى",
          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _buildbody extends StatefulWidget {
  const _buildbody({Key? key}) : super(key: key);

  @override
  State<_buildbody> createState() => _buildbodyState();
}

class _buildbodyState extends State<_buildbody> {
  var urlImages = [
    'assets/hospital_images/1.jpg',
    'assets/hospital_images/2.jpg',
    'assets/hospital_images/3.jpg',
    'assets/hospital_images/4.jpg',
  ];
  var activeIndex = 0;

  var lang = sharedPreferences.getUser('lang');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),

      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 250,
                autoPlay: urlImages.length > 1 ? true : false,
                autoPlayInterval: Duration(milliseconds: 3500),
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                viewportFraction: 1,
                enableInfiniteScroll: urlImages.length > 1 ? true : false,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildimage(urlImage, index);
              },
            ),
          ),
          SizedBox(height: 15),
          Center(child: buildIndicator()),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.5,color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(lang == 'en' ? 'Al_Aml Hospital is one of the best hospitals that cares about providing best medical services and healthcare for its patients.Our main goal is to satisfy, help our patient and provide them with best medical services in least possible time.'
                :'مستشفى الأمل من أفضل المستشفيات التي تهتم بتقديم أفضل الخدمات الطبية والرعاية الصحية لمرضاها.هدفنا الرئيسي هو إرضاء مرضانا ومساعدتهم وتزويدهم بأفضل الخدمات الطبية في أقل وقت ممكن.',
            textDirection:  lang == 'en' ? TextDirection.ltr : TextDirection.rtl,
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 1.2),
            textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }

  Widget buildimage(String urlImage, int index) {
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context, builder: (_) => ImageDialogAssets(img: urlImage));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      effect: SlideEffect(
        dotWidth: 15,
        dotHeight: 15,
        activeDotColor: HexColor('#1C81AB'),
        dotColor: Colors.black12,
      ),
    );
  }
}


Widget BottomNavigationBar(context) {
  return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/footer_2.png"),
          fit: BoxFit.cover,
        ),
      ),
      height: 70,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => chatbot()));
                },
                icon: Image.asset('assets/icons/chatbot.png')),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => Home_page()));
                },
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 40)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => edit_profile()));
                },
                icon: Icon(Icons.person_outline_outlined,
                    color: Colors.white, size: 40)),
          ],
        ),
      ));
}
