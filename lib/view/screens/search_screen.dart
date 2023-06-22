import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/news_cubit/news_cubit.dart';
import '../widgets/article_builder.dart';
import '../widgets/custom_text_field.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomTextField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                child: ArticleBuilder(list: list),
              ),
            ],
          ),
        );
      },
    );
  }
}