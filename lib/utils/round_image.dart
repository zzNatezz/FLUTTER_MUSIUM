import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String url;
  const RoundImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      child: Image.network(
        url,
        fit: BoxFit.fill,
        width: 100,
        height: 100,
      ),
    );
  }
}
