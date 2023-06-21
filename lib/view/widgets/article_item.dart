import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key,required this.index});

  final dynamic index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              image: DecorationImage(
                  image: NetworkImage(index['urlToImage'] ??
                      'https://play-lh.googleusercontent.com/uAu69C99ameBLdlE1Iv2ypibSqwQ3lqQGqm0NzcR1XpQ5gjBfNfW2sotbhfg2hPSjGZ3=w240-h480-rw'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      index['title'],
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    index['publishedAt'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
