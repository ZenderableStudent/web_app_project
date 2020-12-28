import 'package:check_your_bmr_and_bmi/components/background_card.dart';
import 'package:check_your_bmr_and_bmi/components/buttons.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: BackgroundCard(
              childContainer: TextField(
                onChanged: (text) {
                  print("First text field: $text");
                },
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a title',
                    hintStyle: TextStyle(color: Colors.black26),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(),),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(),),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(),),
                ),

              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: BackgroundCard(
              childContainer: TextField(
                autofocus: true,
                onChanged: (text) {
                  print("Second text field: $text");
                },
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a URL or content',
                  hintStyle: TextStyle(color: Colors.black26),
                  focusedBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),

              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage('http://api.qrserver.com/v1/create-qr-code/?data=HelloWorld!&size=300x300'))
                ),
              ),
          ),
          Spacer(),
          Expanded(flex: 1, child: Button(text: Text("Generate"))),
          Expanded(flex: 1, child: Button(text: Text("Save"))),
          Expanded(flex: 1, child: Button(text: Text("QR Gallery"))),
        ],
      ),
    );
  }
}
