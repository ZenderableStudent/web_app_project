import 'package:check_your_bmr_and_bmi/components/background_card.dart';
import 'package:check_your_bmr_and_bmi/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:check_your_bmr_and_bmi/constants.dart';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String title = "Title";
  String url = "Example";
  static const mimeType = "image/png";

  void openInANewTab(url){
    html.window.open(url, '$title');
  }

  void downloadFile(String url){
    html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

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
            flex: 2,
            child: BackgroundCard(
              childContainer: TextField(
                onChanged: (text) {
                  title = text;
                },
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a title',
                  hintStyle: TextStyle(color: Colors.black26),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
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
                  url = text;
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
                  image: DecorationImage(
                      image: NetworkImage(
                          'http://api.qrserver.com/v1/create-qr-code/?data=$url!&size=300x300'))),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 1,
            child: Button(
              onTap: () {
                setState(() {
                  title = title;
                  url = url;
                });
              },
              text: Text("Generate"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Button(
              onTap: () async {
                //TODO: Pick a format and size
                final imgBase64Str = await networkImageToBase64('http://api.qrserver.com/v1/create-qr-code/?data=$url!&size=500x500');
                print(imgBase64Str);
                html.AnchorElement(
                    href: "data:application/octet-stream;charset=utf-16le;base64,$imgBase64Str")
                  ..setAttribute("download", "$title.png")
                  ..click();
              },
              text: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
