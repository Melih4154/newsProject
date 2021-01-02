import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  final String category;
  final title = "News Turkey";

  const HomeView({Key key, this.category}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const String url = "https://www.hurriyet.com.tr/rss/";
  static const String loadingFeedMessage = "yükleniyor...";
  static const String loadingFeedErrorMsg = "Hata Oluştu...";
  String _title;
  RssFeed _feed;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  load() async {
    updateTitle(loadingFeedMessage);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(loadingFeedErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    final client = http.Client();
    final response = await client.get(url + widget.category);
    return RssFeed.parse(response.body);
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subtitle) {
    return Text(
      subtitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  image(imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Image.asset("images/noImage.jpg"),
        width: 70,
        height: 50,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  icon() {
    return Icon(
      Icons.chevron_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = _feed.items[index];
        return ListTile(
          title: title(item.title),
          subtitle: subtitle(item.pubDate.toString()),
          leading: image(item.enclosure.url),
          trailing: icon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () {},
        );
      },
      itemCount: _feed.items.length,
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty() ? Center(child: Text(_title)) : list();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(),
    );
  }

  @override
  void initState() {
    load();
    super.initState();
    updateTitle(_title);
  }
}
