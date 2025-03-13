import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Item> {
  double sliderWidth = 300;
  List<double> dataPercent = [0, 0, 0, 0, 0];
  List<double> dataForCom = [0, 0, 0, 0, 0];
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
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/rickroll.jpg"),fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(dataForCom[0].toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(
                      value: dataPercent[0],
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          dataPercent[0] = (value > 99) ? 100 : value;
                          dataForCom[0] =
                              (value > 99) ? 1023 : (910 * value) / 99;
                          mode = false;
                          sendData("HelloWorld0");
                        });
                      },
                    ),
                  ),
                  sidelabel(dataPercent[0])
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(
                      value: dataPercent[1],
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          dataPercent[1] = (value > 99) ? 100 : value;
                          dataForCom[1] =
                              (value > 99) ? 1023 : (910 * value) / 99;
                          mode = false;
                          sendData("HelloWorld1");
                        });
                      },
                    ),
                  ),
                  sidelabel(dataPercent[1])
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(
                      value: dataPercent[2],
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          dataPercent[2] = (value > 99) ? 100 : value;
                          dataForCom[2] =
                              (value > 99) ? 1023 : (910 * value) / 99;
                          mode = false;
                          sendData("HelloWorld2");
                        });
                      },
                    ),
                  ),
                  sidelabel(dataPercent[2])
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(
                      value: dataPercent[3],
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          dataPercent[3] = (value > 99) ? 100 : value;
                          dataForCom[3] =
                              (value > 99) ? 1023 : (910 * value) / 99;
                          mode = false;
                          sendData("HelloWorld3");
                        });
                      },
                    ),
                  ),
                  sidelabel(dataPercent[3])
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(
                      value: dataPercent[4],
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          dataPercent[4] = (value > 99) ? 100 : value;
                          dataForCom[4] =
                              (value > 99) ? 1023 : (910 * value) / 99;
                          mode = false;
                          sendData("HelloWorld4");
                        });
                      },
                    ),
                  ),
                  sidelabel(dataPercent[4])
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    mode = !mode;
                  });
                },
                child: mode ? Text("Auto") : Text("Maual"),
                style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll<Color>(
                        mode ? Colors.green : Colors.red)),
              ),
            ],
          )),
    );
  }

  Widget sidelabel(double value) => Container(
        width: 40,
        child: Text(
          value.toStringAsFixed(1),
          textAlign: TextAlign.center,
        ),
      );
}
