import 'package:circle_flags/circle_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/news/domain/entities/category.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/news_categories_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/trending_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/views/section_news_categories.dart';
import 'package:flutter_news_app/src/news/presentation/views/section_news_headline.dart';
import 'package:flutter_news_app/src/news/presentation/views/section_news_trending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category selectedCategory = Category(
    name: 'Business',
    key: 'business',
    imagePath: 'assets/images/business.jpeg',
    isSelected: false,
  );
  int page = 1;
  String _countryCode = 'us';
  String _countryName = 'United States';

  void loadNewsDataFirstTime() {
    context.read<NewsCategoriesBloc>().add(const GetNewsCategoriesEvent());
    context.read<TrendingNewsBloc>().add(
          GetTrendingNewsEvent(
            categoryType: selectedCategory.key,
            page: 1,
            countryCode: _countryCode,
          ),
        );
    context.read<HeadlineNewsBloc>().add(
          GetHeadlineNewsEvent(
            categoryType: selectedCategory.key,
            page: 1,
            countryCode: _countryCode,
          ),
        );
  }

  void getAllNewsData() {
    context.read<NewsCategoriesBloc>().add(const GetNewsCategoriesEvent());
    context.read<TrendingNewsBloc>().add(
          GetTrendingNewsEvent(
            categoryType: selectedCategory.key,
            page: page,
            countryCode: _countryCode,
          ),
        );
    context.read<HeadlineNewsBloc>().add(
          GetHeadlineNewsEvent(
            categoryType: selectedCategory.key,
            page: page,
            countryCode: _countryCode,
          ),
        );
  }

  void getTrendingData() {
    context.read<TrendingNewsBloc>().add(
          GetTrendingNewsEvent(
            categoryType: selectedCategory.key,
            page: page,
            countryCode: _countryCode,
          ),
        );
  }

  void updateSelectedCategory(Category category) {
    if (category.key == selectedCategory.key) {
      return;
    }

    setState(() {
      selectedCategory = category;
    });

    getTrendingData();
  }

  void updateCountry(String code) {
    if (code == _countryCode) {
      return;
    }

    setState(() {
      _countryCode = code.toLowerCase();
    });

    getAllNewsData();
  }

  @override
  void initState() {
    super.initState();
    getAllNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('Flutter'),
                Text(
                  'News',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            GestureDetector(
              child: Row(
                children: [
                  CircleFlag(
                    _countryCode,
                    size: 24,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                  ),
                ],
              ),
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    updateCountry(country.countryCode);
                  },
                );
              },
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            const SectionNewsHeadline(),
            const SizedBox(height: 30),
            SectionNewsCategories(
              onCategorySelected: (category) {
                updateSelectedCategory(category);
              },
            ),
            const SizedBox(height: 20),
            SectionNewsTrending(selectedCategory: selectedCategory),
          ],
        ),
      ),
    );
  }
}
