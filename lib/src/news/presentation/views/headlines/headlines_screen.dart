import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/article_list_vertical.dart';
import 'package:flutter_news_app/src/news/presentation/widgets/main_app_bar.dart';

class HeadlinesScreen extends StatefulWidget {
  const HeadlinesScreen({super.key});

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  String _countryCode = 'us';

  @override
  void initState() {
    super.initState();
    getHeadlineNewsFirstPage();
  }

  void getHeadlineNewsFirstPage() {
    context.read<HeadlineNewsBloc>().add(
          GetHeadlineNewsEvent(
            page: 1,
            countryCode: _countryCode,
          ),
        );
  }

  void updateCountry(String code) {
    if (code == _countryCode) {
      return;
    }

    setState(() {
      _countryCode = code.toLowerCase();
    });

    getHeadlineNewsFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onCountrySelected: (String code) {updateCountry(code);},
        countryCode: _countryCode,
        showCountrySelector: true,
      ),
      body: BlocConsumer<HeadlineNewsBloc, HeadlineNewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is LoadingHeadlineNews
              ? const Center(child: CircularProgressIndicator())
              : state is HeadlineNewsError
                  ? Center(child: Text(state.message))
                  : state is HeadlineNewsLoaded
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ArticleListVertical(
                                articles: state.articles,
                                onItemSelected: (url) {},
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
