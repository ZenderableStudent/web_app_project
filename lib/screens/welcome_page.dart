import 'package:check_your_bmr_and_bmi/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:check_your_bmr_and_bmi/screens/main_page.dart';
import 'package:check_your_bmr_and_bmi/screens/qr_code_generator.dart';
import 'package:check_your_bmr_and_bmi/constants.dart';
import 'package:check_your_bmr_and_bmi/components/background_card.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: BackgroundCard(
                color: kActiveCardColor,
                childContainer: Expanded(
                  child: RawMaterialButton(
                    child:
                        Center(child: Text('BMR Calculator', style: kResultsTitleTextStyle)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                )),
          ),
          VerticalDivider(
              thickness: 2,
              color: kActiveCardColor,
              indent: 100,
              endIndent: 100
            ),
          Expanded(
            child: BackgroundCard(
              color: kActiveCardColor,
              childContainer: Expanded(
                child: RawMaterialButton(
                  child:
                      Center(child: Text('QR Code Generator', style: kResultsTitleTextStyle)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRCodeGenerator()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Center(
          child: Text(
            'Pick app',
            style: TextStyle(
              fontFamily: "Jaapokki",
            ),
          ),
        ),
      ),
    );
  }
}
