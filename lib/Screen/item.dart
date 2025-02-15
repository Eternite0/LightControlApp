import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Item> {
  double sliderWidth = 300;
  double Val0 = 0;
  double Val1 = 0;
  double Val2 = 0;
  double Val3 = 0;
  double Val4 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sliderWidth,
                child: Slider(
                  value: Val0,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      Val0 = value;
                    });
                  },
                ),
              ),
              sidelabel(Val0)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sliderWidth,
                child: Slider(
                  value: Val1,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      Val1 = value;
                    });
                  },
                ),
              ),
              sidelabel(Val1)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sliderWidth,
                child: Slider(
                  value: Val2,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      Val2 = value;
                    });
                  },
                ),
              ),
              sidelabel(Val2)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sliderWidth,
                child: Slider(
                  value: Val3,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      Val3 = value;
                    });
                  },
                ),
              ),
              sidelabel(Val3)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sliderWidth,
                child: Slider(
                  value: Val4,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      Val4 = value;
                    });
                  },
                ),
              ),
              sidelabel(Val4)
            ],
          ),
        ],
      )),
    );
  }

  Widget sidelabel(double value) => Container(
        width: 30,
        child: Text(
          value.round().toString(),
          textAlign: TextAlign.center,
        ),
      );
}
