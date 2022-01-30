import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _assetpath;

  ImageBanner(this._assetpath);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(
        height: 200.0
      ),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Image.asset(
        _assetpath,
        fit: BoxFit.cover,
        ),
    );
  }
}
