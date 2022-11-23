import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuestionPlaceholderWidget extends StatelessWidget {
  const QuestionPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Widget lines = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    Widget answer = Container(
      width: double.infinity,
      height: 50.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.blueAccent.withOpacity(0.5),
      child: EasySeparatedColumn(
        children: [
          EasySeparatedColumn(
            children: [
              lines,
              lines,
              lines,
              lines,
            ],
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
          answer,
          answer,
          answer,
        ],
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
