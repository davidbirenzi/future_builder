import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Headlines',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NewsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<List<Article>>? _newsFuture;
  final String apiKey = '0ed4ec5a939343f2bb6ec0ee71dadb3a';

  Future<List<Article>> fetchNews() async {
    await Future.delayed(Duration(seconds: 4));

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson
          .take(5)
          .map((json) => Article.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Headlines'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: _newsFuture == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.newspaper,
                      size: 80,
                      color: const Color.fromARGB(255, 0, 99, 180),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Stay Updated with Latest News',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _newsFuture = fetchNews();
                        });
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('Fetch News Headlines'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : FutureBuilder<List<Article>>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Fetching latest news...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Please wait',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.red[600]),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _newsFuture = null;
                              });
                            },
                            child: Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final articles = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.trending_up, color: Colors.blue[600]),
                              SizedBox(width: 8),
                              Text(
                                'Top 5 Headlines',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _newsFuture = null;
                                  });
                                },
                                icon: Icon(Icons.refresh, color: Colors.blue[600]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              final article = articles[index];
                              return Card(
                                margin: EdgeInsets.only(bottom: 12),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(16),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue[100],
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    article.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: article.description.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            article.description,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : null,
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No news available',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}

class Article {
  final String title;
  final String description;
  final String url;

  Article({required this.title, required this.description, required this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
