import 'package:flutter/material.dart';

class ShowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 5,
        ),
        Text('Loading...')
      ],
    ));
  }
}
