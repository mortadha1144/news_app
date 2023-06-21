import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/widgets/article_item.dart';

import 'custom_divider.dart';

class ArticleBuilder extends StatelessWidget {
  const ArticleBuilder({super.key, required this.list});

  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ArticleItem(index: list[index]),
        separatorBuilder: (context, index) => const CustomDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }
}
