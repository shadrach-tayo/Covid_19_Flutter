import 'package:flutter/material.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/widgets/header.dart';
import 'package:flutter_svg/svg.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = 'info_screen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ScrollController scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  onScroll() {
    setState(() {
      offset = scrollController.hasClients ? scrollController.offset : 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              offset: offset,
              image: 'assets/icons/coronadr.svg',
              textBottom: 'About Covid-19',
              textTop: 'Get to Know more',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Symptoms',
                    style: KTitleTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SymptomCard(
                          image: 'assets/images/headache.png',
                          title: 'Headache',
                        ),
                        SymptomCard(
                          image: 'assets/images/caugh.png',
                          title: 'Cough',
                        ),
                        SymptomCard(
                          image: 'assets/images/fever.png',
                          title: 'Fever',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Prevention',
                    style: KTitleTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PreventionCard(
                    image: 'assets/images/wear_mask.png',
                    title: 'Wear face mask',
                    text:
                        'Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks',
                  ),
                  PreventionCard(
                    image: 'assets/images/wash_hands.png',
                    title: 'Wash your hands',
                    text:
                        'Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  SymptomCard({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(right: 20.0, bottom: 20),
      decoration:
          KCardDecoration.copyWith(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: <Widget>[
          Expanded(child: Image.asset(image)),
          Text(
            '$title',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class PreventionCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;

  PreventionCard({this.image, this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10.0),
            padding: const EdgeInsets.fromLTRB(165.0, 15.0, 20.0, 15),
            decoration: KCardDecoration.copyWith(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: KTitleTextStyle.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: KTitleTextStyle.copyWith(fontSize: 12),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset('assets/icons/forward.svg'),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            child: Image.asset(
              image,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
