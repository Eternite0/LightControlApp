import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
  bool mode = true;

  BluetoothDevice? _device;
  BluetoothCharacteristic? _characteristic;

  @override
  void initState() {
    super.initState();
    connectToFirstPairedDevice(); // Auto-connect on startup
  }

  void connectToFirstPairedDevice() async {
    List<BluetoothDevice> bondedDevices = await FlutterBluePlus.bondedDevices;
    if (bondedDevices.isNotEmpty) {
      _device = bondedDevices.first; // Connect to the first paired device
      await _device!.connect();
      discoverServices();
    }
  }

  void discoverServices() async {
    if (_device == null) return;
    List<BluetoothService> services = await _device!.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          setState(() {
            _characteristic = characteristic;
          });
        }
      }
    }
  }

  void sendData(String message) async {
    if (_characteristic != null) {
      await _characteristic!.write(message.codeUnits);
    }
  }

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
                      mode = false;
                      sendData("HelloWorld0");
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
                      mode = false;
                      sendData("HelloWorld1");
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
                      mode = false;
                      sendData("HelloWorld2");
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
                      mode = false;
                      sendData("HelloWorld3");
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
                      mode = false;
                      sendData("HelloWorld4");
                    });
                  },
                ),
              ),
              sidelabel(Val4)
            ],
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                mode = !mode;
              });
            },
            child: mode ? Text("Auto") : Text("Maual"),
            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll<Color>(mode ? Colors.green : Colors.red)),
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
