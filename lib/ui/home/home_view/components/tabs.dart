import 'package:firebaseworks/ui/home/home_view/home_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Haber Ara...",
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            indicatorColor: Colors.purpleAccent,
            unselectedLabelColor: Colors.blueGrey,
            isScrollable: true,
            labelColor: Colors.purpleAccent,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            controller: _controller,
            tabs: [
              Tab(
                text: "AnaSayfa",
              ),
              Tab(
                text: "Spor",
              ),
              Tab(
                text: "Ekonomi",
              ),
              Tab(
                text: "Gündem",
              ),
              Tab(
                text: "Magazin",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                HomeView(
                  category: "anasayfa",
                ),
                HomeView(
                  category: "spor",
                ),
                HomeView(
                  category: "ekonomi",
                ),
                HomeView(
                  category: "gundem",
                ),
                HomeView(
                  category: "magazin",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
