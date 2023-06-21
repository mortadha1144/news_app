import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/article_builder.dart';
import 'news_cubit/news_cubit.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).science;
        return ArticleBuilder(list: list,);
      },
    );
  }
}