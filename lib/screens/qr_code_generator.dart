import 'package:check_your_bmr_and_bmi/components/background_card.dart';
import 'package:check_your_bmr_and_bmi/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:check_your_bmr_and_bmi/constants.dart';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String title = "Title";
  String url = "Example";

  var selectedFormat = "png";
  var selectedSize = 500;
  var color = Colors.black;
  var selectedColor = (Colors.black).toHex().toString().replaceAll('#ff', '');

  List<String> formats = <String>[
    'png',
    'jpg',
    'jpeg',
    'gif',
    'svg',
    'eps',
  ];

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
              color: Colors.transparent,
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
              color: Colors.transparent,
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
                          'http://api.qrserver.com/v1/create-qr-code/?data=$url&size=200x200&color=$selectedColor'))),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    text: Text("Format"),
                    onTap: () {
                      showMaterialRadioPicker(
                        context: context,
                        title: "Pick a format",
                        headerColor: Colors.grey,
                        items: formats,
                        selectedItem: selectedFormat,
                        onChanged: (value) => setState(() => selectedFormat = value),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Button(
                    text: Text("Size"),
                    onTap: () {
                      showMaterialNumberPicker(
                        context: context,
                        title: "Pick a size (in px eq. 1000x1000)",
                        headerColor: Colors.grey,
                        maxNumber: selectedFormat != "eps" && selectedFormat != "svg" ? 1000 : 1000000,
                        minNumber: selectedFormat != "eps" && selectedFormat != "svg" ? 100 : 1000,
                        step: selectedFormat != "eps" && selectedFormat != "svg" ? 100 : 1000,
                        selectedNumber: selectedSize,
                        onChanged: (value) => setState(() => selectedSize = value),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Button(
                    text: Text("Color"),
                    onTap: () {
                      showMaterialColorPicker(
                        context: context,
                        title: "Pick a color",
                        headerColor: Colors.grey,
                        selectedColor: color,
                        onChanged: (value) => setState(() => color = value),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    color: Colors.indigo,
                    onTap: () {
                      setState(() {
                        title = title;
                        url = url;
                        selectedSize = selectedSize;
                        selectedFormat = selectedFormat;
                        selectedColor = (color).toHex().toString().replaceAll('#ff', '');
                      });
                    },
                    text: Text("Generate"),
                  ),
                ),
                Expanded(
                  child: Button(
                    color: Colors.indigo,
                    onTap: () async {
                      final imgBase64Str = await networkImageToBase64(
                          'http://api.qrserver.com/v1/create-qr-code/?data=$url&size=${selectedSize}x$selectedSize&color=$selectedColor&format=$selectedFormat');
                      print(imgBase64Str);
                      html.AnchorElement(
                          href:
                              "data:application/octet-stream;charset=utf-16le;base64,$imgBase64Str")
                        ..setAttribute("download", "$title.$selectedFormat")
                        ..click();
                    },
                    text: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
