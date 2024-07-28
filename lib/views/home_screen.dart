import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_provider.dart';
import '../utils/time_utils.dart'; // Import the time utility function

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0c54BE),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'MyNews',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
             Image.asset('assets/images/send.png'),
              SizedBox(width: screenWidth * 0.01),
              Text(
                'IN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (newsProvider.news == null || newsProvider.news!.articles!.isEmpty) {
            return Center(
              child: Text('No news articles available.'),
            );
          }

          return ListView.builder(
            itemCount: newsProvider.news!.articles!.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Top Headlines',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      color:Colors.black
                    ),
                  ),
                );
              }
              final article = newsProvider.news!.articles![index - 1];

              // Use the utility function to format time
              String timeAgo = formatTimeAgo(article.publishedAt);

              return Card(
                color:Color(0xFFF5F9FD),
                margin: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text(
                              article.source?.name ?? 'News Source',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:Colors.black,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                fontFamily: 'Poppins',// Responsive font size
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              article.description ?? 'No Description',
                              style: TextStyle(
                                  color:Colors.black,
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontFamily: 'Poppins',// Responsive font size
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              timeAgo,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                fontFamily: 'Poppins',// Responsive font size
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3, // Responsive image width
                          height: MediaQuery.of(context).size.width * 0.3, // Responsive image height
                          child: article.urlToImage != null
                              ? Image.network(
                            article.urlToImage!,
                            fit: BoxFit.cover,
                          )
                              : Image.asset('assets/images/news.png', fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
