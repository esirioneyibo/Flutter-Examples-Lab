import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(
          brightness: Brightness.dark, primaryColorBrightness: Brightness.dark),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = new PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> pages = <String, Widget>{
      'My Music': Center(
        child: Text('My Music not implemented'),
      ),
      'Shared': Center(
        child: Text('Shared not implemented'),
      ),
      'Feed': Feed(),
    };

    TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              const Color.fromARGB(255, 253, 72, 72),
              const Color.fromARGB(255, 87, 97, 249),
            ],
            stops: [0.0, 1.0],
          )),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Demo',
                style: textTheme.headline.copyWith(
                    color: Colors.grey.shade800.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: Center(
              child: ClipOval(
                child: Image.network('http://i.imgur.com/TtNPTe0.jpg'),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              )
            ],
            title: const Text('tofu\'s songs'),
            bottom: CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  final PageController pageController;
  final List<String> pageNames;

  CustomTabBar({this.pageController, this.pageNames})
      : super(listenable: pageController);

  @override
  final Size preferredSize = Size(0.0, 40.0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(pageNames.length, (int index) {
          return InkWell(
            child: Text(
              pageNames[index],
              style: textTheme.subhead.copyWith(
                  color: Colors.white
                      .withOpacity(index == pageController.page ? 1.0 : 0.2)),
            ),
            onTap: () {
              pageController.animateToPage(index,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300));
            },
          );
        }),
      ),
    );
  }
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Song(
        title: 'Trapadelic lobo',
        author: 'Lillobobeats',
        likes: 4,
      ),
      Song(title: 'Different', author: 'younglowkey', likes: 23),
      Song(title: 'Future', author: 'younglowkey', likes: 2)
    ]);
  }
}

class Song extends StatelessWidget {
  const Song({this.title, this.author, this.likes});

  final String title;
  final String author;
  final int likes;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://thecatapi.com/api/images/get?format=src'
                    '&size=small&type=jpg#${title.hashCode}'),
                radius: 20.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(title, style: textTheme.subhead),
                  Text(author, style: textTheme.caption),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                child: Icon(Icons.play_arrow, size: 40.0),
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, size: 25.0),
                    Text('${likes ?? ''}'),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
