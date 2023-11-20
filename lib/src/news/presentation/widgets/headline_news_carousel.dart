import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/domain/entities/article.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeadlineNewsCarousel extends StatefulWidget {
  final List<Article> articles;
  final Function(String url) onNewsSelected;

  const HeadlineNewsCarousel({
    super.key,
    required this.articles,
    required this.onNewsSelected,
  });

  @override
  State<HeadlineNewsCarousel> createState() => _HeadlineNewsCarouselState();
}

class _HeadlineNewsCarouselState extends State<HeadlineNewsCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.articles.isEmpty
        ? const SizedBox(
            height: 250,
            child: Center(
              child: Text('No Headline news available'),
            ),
          )
        : Column(
            children: [
              CarouselSlider.builder(
                itemCount: widget.articles.length,
                itemBuilder: (context, index, realIndex) {
                  String? newsUrl = widget.articles[index].url;
                  String? url = widget.articles[index].urlToImage;
                  String? title = widget.articles[index].title;
                  return buildImage(
                    url,
                    index,
                    title,
                    () {
                      widget.onNewsSelected(newsUrl);
                    },
                  );
                },
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 17.0),
              Center(child: buildIndicator()),
            ],
          );
  }

  Widget buildImage(
    String image,
    int index,
    String name,
    Function onNewsSelected,
  ) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: GestureDetector(
          onTap: () {
            onNewsSelected();
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 250,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: image,
                ),
              ),
              Container(
                height: 250,
                padding: const EdgeInsets.only(left: 10.0),
                margin: const EdgeInsets.only(top: 170.0),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Center(
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.articles.length,
        effect: const SlideEffect(
          dotWidth: 6,
          dotHeight: 6,
          activeDotColor: Colors.blue,
        ),
      );
}
