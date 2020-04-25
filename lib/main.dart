import 'package:covid_19/info_screen.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/widgets/header.dart';
import 'package:flutter_svg/svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
          textTheme: TextTheme(body1: TextStyle(color: kBodyTextColor))),
      initialRoute: MyHomePage.routeName,
      routes: {
        '/': (context) => MyHomePage(),
        MyHomePage.routeName: (context) => MyHomePage(),
        InfoScreen.routeName: (context) => InfoScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  static const routeName = 'home';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentCountry = 'Nigeria';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyHeader(
              offset: offset,
              image: 'assets/icons/Drcorona.svg',
              textTop: 'All you need',
              textBottom: 'is to stay at home',
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE5E5E5)),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset('assets/icons/maps-and-flags.svg'),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                        hint: Text('Select Country'),
                        value: _currentCountry,
                        icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                        isExpanded: true,
                        underline: SizedBox(),
                        items: ['Nigeria', 'Ghana', 'South Africa', 'Algeria']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _currentCountry = value;
                          });
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // case update section header
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Case Update\n', style: KTitleTextStyle),
                            TextSpan(
                                text: 'Newest update April 25',
                                style: TextStyle(
                                    color: kTextLightColor, fontSize: 12.0)),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        'see details',
                        style: KLinkTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: KCardDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Counter(
                            color: kInfectedColor,
                            title: 'Infected',
                            number: 2056),
                        Counter(
                            color: kDeathColor, title: 'Deaths', number: 55),
                        Counter(
                            color: kRecovercolor,
                            title: 'Recovered',
                            number: 46),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // case update section header
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Spread of Virus', style: KTitleTextStyle),
                      Spacer(),
                      Text(
                        'see details',
                        style: KLinkTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: KCardDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
