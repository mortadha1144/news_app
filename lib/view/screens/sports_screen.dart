import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/news_cubit/news_cubit.dart';
import '../widgets/article_builder.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).sports;
        return ArticleBuilder(list: list,);
      },
    );
  }
}