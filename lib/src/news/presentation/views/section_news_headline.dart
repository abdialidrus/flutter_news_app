import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/headline_news_carousel.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/section_header.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class SectionNewsHeadline extends StatefulWidget {
  final Function(String url) onNewsSelected;
  const SectionNewsHeadline({super.key, required this.onNewsSelected});

  @override
  State<SectionNewsHeadline> createState() => _SectionNewsHeadlineState();
}

class _SectionNewsHeadlineState extends State<SectionNewsHeadline> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<HeadlineNewsBloc, HeadlineNewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is LoadingHeadlineNews
              ? const SizedBox(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : state is HeadlineNewsError
                  ? Text(state.message)
                  : state is HeadlineNewsLoaded
                      ? Column(
                          children: [
                            SectionHeader(
                              title: 'Headline news',
                              onViewAllPressed: () {
                                showToast('Show all Headline news',
                                    context: context);
                              },
                            ),
                            HeadlineNewsCarousel(
                              articles: state.articles,
                              onNewsSelected: (url) {
                                widget.onNewsSelected(url);
                              },
                            ),
                          ],
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
