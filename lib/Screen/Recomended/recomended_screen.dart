import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mero_mahinaa/provider/period_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constant/blogDetail.dart';
import '../../model/blog.dart';

class RecomendedScreen extends StatelessWidget {
  const RecomendedScreen({super.key});

  List<Blog> bleeding(String bleedingIntensity, String pain) {
    var i = 0;
    List<Blog> bloglist = [];

    if (bleedingIntensity == 'Normal') {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['isMenorrhagia'] == 'false') &&
            blogDetail[i]['disease'] == 'null') {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );

          bloglist.add(newBlog);
        }
        i = i + 1;
      }
    } else if (bleedingIntensity.contains('low')) {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['isMenorrhagia'] == 'false') &&
            blogDetail[i]['disease'] == 'hypomenorrhea') {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );

          bloglist.add(newBlog);
        }
        i = i + 1;
      }
    } else if (bleedingIntensity.contains('high')) {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['isMenorrhagia'] == 'true')) {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );
          bloglist.add(newBlog);
        }
        i = i + 1;
      }
    }
    if (pain.contains('high') || pain.contains('High')) {
      i = 0;
      while (i < blogDetail.length) {
        if ((blogDetail[i]['disease'] == 'dysmenorrhea') ||
            (blogDetail[i]['disease'] == 'Anemia')) {
          final newBlog = Blog(
            url: blogDetail[i]['url'] as String,
            imageUrl: blogDetail[i]['ImageUrl'] as String,
            youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
            isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
            disease: blogDetail[i]['disease'] as String,
            isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
            title: blogDetail[i]['title'] as String,
            description: blogDetail[i]['description'] as String,
          );
          bloglist.add(newBlog);
        }

        i = i + 1;
      }
    } else {
      print("else case running");
      i = 0;
      while (i < blogDetail.length) {
        final newBlog = Blog(
          url: blogDetail[i]['url'] as String,
          imageUrl: blogDetail[i]['ImageUrl'] as String,
          youtubeUrl: blogDetail[i]['YoutubeUrl'] as String,
          isAgeBelow: blogDetail[i]['isAgeBelow'] as int,
          disease: blogDetail[i]['disease'] as String,
          isMenorrhagia: blogDetail[i]['isMenorrhagia'] as String,
          title: blogDetail[i]['title'] as String,
          description: blogDetail[i]['description'] as String,
        );
        bloglist.add(newBlog);

        i = i + 1;
      }
    }

    return bloglist;
  }

  static const BleedingIntensity = ["Heavy", "Normal", "Low", "abc"];
  static const PainIntensity = ["High", "Moderate", "Low", "abc"];

  @override
  Widget build(BuildContext context) {
    final listOfPeriods = Provider.of<PeriodProvider>(context)
        .periodListProvideFromAlreadyFetched();
    List<Blog> bloglist = [];
    bloglist = bleeding(
        BleedingIntensity[
            // ignore: unnecessary_null_comparison
            listOfPeriods == null ? listOfPeriods[0].bloodIndex : 3],
        PainIntensity[
            // ignore: unnecessary_null_comparison
            listOfPeriods == null ? listOfPeriods[0].painIndex : 3]);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: ListView.builder(
          itemCount: bloglist.length,
          itemBuilder: (context, index) => Column(
            children: [
              InkWell(
                onTap: () async {
                  String url = bloglist[index].url;
                  try {
                    if (await canLaunchUrl(Uri())) {
                      await launchUrl(Uri());
                    } else {
                      throw 'Could not launch $url';
                    }
                  } catch (error) {
                    print(error);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.amber,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          //padding:EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              bloglist[index].imageUrl,
                              height: 0.3.sh,
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      /*Center(
                        child: Image.network(
                          bloglist[index].imageUrl ??
                              'https://i.pinimg.com/736x/56/58/eb/5658ebd81676b99acd753488dcadd054.jpg',
                          height: 100,
                        ),
                      ),*/
                      //SizedBox(height: 7),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.red[400]?.withOpacity(0.5),
                          // border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bloglist[index].title,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              bloglist[index].description,
                              maxLines: 3,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  color: Colors.red[800],
                                  onPressed: () async {
                                    String url = bloglist[index].youtubeUrl;
                                    try {
                                      if (await canLaunchUrl(Uri())) {
                                        await launchUrl(Uri());
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    } catch (error) {
                                      print(error);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.youtube_searched_for,
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
