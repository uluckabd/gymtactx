import 'package:flutter/material.dart';
import 'package:gymtactx/widgets.dart';

class PhotoTestPage extends StatefulWidget {
  const PhotoTestPage({super.key});

  @override
  State<PhotoTestPage> createState() => _PhotoTestPageState();
}

class _PhotoTestPageState extends State<PhotoTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            height: 200,
            child: AppCard(
              title: "ölçü",
              imagePath: 'assets/images/cards/olculerim.png',
            ),
          ),
        ),
      ),
    );
  }
}
