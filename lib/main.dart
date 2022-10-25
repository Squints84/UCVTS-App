import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'custom_icons_icons.dart';
import 'extra.dart';
import 'panel.dart';

void main() => runApp(const MyApp());

PanelController _pc = PanelController();
Slidey slide = Slidey(); // test dawg

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // Application name
        title: 'Flutter Test Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.blue[50],
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        // A widget which will be started on application startup
        home: const MyHomePage(
            title: 'Union County\nVocational-Technical Schools'));
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                leading: Transform.scale(
                    scale: 2,
                    child: IconButton(
                      icon: const ImageIcon(AssetImage('assets/UCVTS.png')),
                      onPressed: () async {
                        if (!await launchUrl(
                            Uri.parse('https://www.ucvts.org/'))) {
                          throw 'Could not reach UCVTS.org at this time.';
                        }
                      },
                    )),
                centerTitle: true,
                title: Text(title,
                    style: const TextStyle(
                        fontSize: 17.5, decoration: TextDecoration.underline),
                    textAlign: TextAlign.center),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.check_box),
                    tooltip: 'Fact  Checker',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text.rich(TextSpan(
                              style: TextStyle(fontSize: 20),
                              children: <TextSpan>[
                            TextSpan(text: '^ The above message is '),
                            TextSpan(
                              text: 'TRUE',
                              style: TextStyle(
                                color: Color(0xff00ff08),
                                fontWeight: FontWeight.bold)),
                            TextSpan(text: '!!!')
                          ]))));
                    },
                  )
                ]),
            bottomNavigationBar: Container(
							color: const Color(0xff2196f3),
							child: TabBar(onTap: (int i) => _pc.close(), tabs: const [
								Tab(icon: Icon(CustomIcons.ait)),
								Tab(icon: Icon(CustomIcons.theaterMasks)),
								Tab(icon: Icon(Icons.assignment_late)), // *person in desk but person is just a silhoutte*
								Tab(icon: Icon(Icons.photo_library))
							])),
            body: Stack(children: <Widget>[
              TabBarView(children: [
                // The displays of the different tabs, in order (VERY IMPORTANT)
                ExtraStuff.trueCenterAlign([ExtraStuff.weLoveAIT]),
                Image.asset('assets/Dole.jpg', alignment: Alignment.center),
                ExtraStuff.trueCenterAlign([
                  const Icon(CustomIcons.ucvts),
                  Text("${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}")
                ]),
                ExtraStuff.trueCenterAlign([
                  Text('tabBar Height = 29\n\nOG Panel Height = ${screenHeight * 0.8}\n vs.\nError Height = ${22 + (Slidey.buttonHeight * 4) + 40}')
                ])
              ], physics: const NeverScrollableScrollPhysics()),
              SlidingUpPanel(
                  controller: _pc,
                  minHeight: 29,
                  maxHeight: screenHeight *
                      0.7, // Height of the gripbar (minus some padding) + height of the buttons + height of the seperators between the buttons
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  color: const Color(
                      0xfff2f2f2), // I only colored it so you can see the difference between the phone border and the panel
                  panel: slide.panel)
            ])));
  }
}
// screenHeight * 0.8, // (22 + (Slidey.buttonHeight * 4) + 40)
// (Backup value for maxHeight as using a smaller size
//  resulted in Alex being unable to access the Slidey)

class StaffDirectoryPage extends StatelessWidget {
  const StaffDirectoryPage({Key? key}) : super(key: key);
  final String title = "Staff Directory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(title,
              style: const TextStyle(fontSize: 17.5),
              textAlign: TextAlign.center)),
      body: const Center(child: Text("UCVTS Staff :)")),
    );
  }
}

class ImportantFormsPage extends StatelessWidget {
  const ImportantFormsPage({Key? key}) : super(key: key);
  final String title = "Important Forms";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(title,
              style: const TextStyle(fontSize: 17.5),
              textAlign: TextAlign.center)),
      body: const Center(child: Text("UCVTS Forms :)")),
    );
  }
}

class DistrictNewsLetterPage extends StatelessWidget {
  DistrictNewsLetterPage({Key? key}) : super(key: key);
  final String title = "District Newsletter";
  final List months = [
    'JANUARY',
    'FEBUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(title,
              style: const TextStyle(fontSize: 17.5),
              textAlign: TextAlign.center)),
      body: Center(
          child: const PDF().cachedFromUrl(
              'https://www.ucvts.org/cms/lib/NJ50000421/Centricity/Domain/4/UCVTS%20DISTRICT%20NEWSLETTER%20${months[DateTime.now().month + 1]}%20${DateTime.now().year.toString()}.pdf')),
    );
  }
}
