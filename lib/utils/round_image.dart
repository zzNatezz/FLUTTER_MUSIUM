import 'package:flutter/material.dart';

ClipRRect RoundImage(String url) {
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      child: Image.network(url, fit: BoxFit.fill, width: 100, height: 100));
}
