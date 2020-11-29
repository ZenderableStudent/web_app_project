import 'package:check_your_bmr_and_bmi/components/background_card.dart';
import 'package:flutter/material.dart';
import 'package:check_your_bmr_and_bmi/constants.dart';

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Center(
          child: Text(
            'QR Code Generator',
            style: TextStyle(
              fontFamily: "Jaapokki",
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: BackgroundCard(
              childContainer: TextField(
                onChanged: (text) {
                  print("First text field: $text");
                },
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a text',
                    hintStyle: TextStyle(color: Colors.black26),
                    focusedBorder: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
