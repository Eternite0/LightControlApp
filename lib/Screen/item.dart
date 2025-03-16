import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _characteristic;
  List<BluetoothDevice> availableDevices = [];
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    scanForDevices();
  }

  void requestPermissions() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();
  }

  void scanForDevices() async {
    print("Scanning for BLE devices...");
    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        availableDevices = results
            .map((r) => r.device)
            .where((d) => d.name.isNotEmpty)
            .toList();
      });
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    setState(() {
      _device = device;
      isConnected = false;
    });
    try {
      await _device!.connect();
      setState(() {
        isConnected = true;
      });
      discoverServices();
    } catch (e) {
      print("Connection failed: \$e");
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
          print("Writable characteristic found!");
        }
      }
    }
  }

  void sendData(String message) async {
    if (_characteristic != null) {
      try {
        print("Sending: \$message");
        await _characteristic!.write(message.codeUnits);
      } catch (error) {
        print("Write failed: \$error");
      }
    } else {
      print("No writable characteristic found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLE Device Selection"),
        actions: [
          DropdownButton<BluetoothDevice>(
            hint: Text("Select Device"),
            value: _device,
            onChanged: (BluetoothDevice? device) {
              if (device != null) {
                connectToDevice(device);
              }
            },
            items: availableDevices.map((device) {
              return DropdownMenuItem(
                value: device,
                child: Text(device.name.isNotEmpty
                    ? device.name
                    : device.id.toString()),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(isConnected
              ? "Connected to: \${_device?.name}"
              : "Not Connected"),
          for (int i = 0; i < 5; i++) buildSlider(i),
        ],
      ),
    );
  }

  Widget buildSlider(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: Slider(
            value: 50, // Placeholder value
            min: 0,
            max: 100,
            onChanged: (value) {
              sendData("HelloWorld\$index");
            },
          ),
        ),
      ],
    );
  }
}
