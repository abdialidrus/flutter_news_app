import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/services/injection_container.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/headline_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/news_categories_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/trending_news_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<NewsCategoriesBloc>()),
        BlocProvider(create: (context) => sl<HeadlineNewsBloc>()),
        BlocProvider(create: (context) => sl<TrendingNewsBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter News App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
