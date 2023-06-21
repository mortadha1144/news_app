import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen/news_cubit/news_cubit.dart';
import '../widgets/article_builder.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).business;
        return ArticleBuilder(list: list,);
      },
    );
  }
}