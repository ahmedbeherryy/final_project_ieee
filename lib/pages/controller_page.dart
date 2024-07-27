import 'package:final_project_ieee/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import '../constants.dart';
import '../widgets/custom_button.dart';


class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final ssidController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _startProvisioning() async {
    final provisioner = Provisioner.espTouch();

    provisioner.listen((response) {
      Navigator.of(context).pop(response);
    });

    // Check if the password field is empty
    if (passwordController.text.isEmpty) {
      provisioner.start(ProvisioningRequest.fromStrings(
        ssid: ssidController.text,
        bssid: 'c4:de:e2:22:bf:b9',
        // bssid: '00:00:00:00:00:00',
      ));
    } else {
      // Start provisioning with both SSID and password
      provisioner.start(ProvisioningRequest.fromStrings(
        ssid: ssidController.text,
        bssid: 'c4:de:e2:22:bf:b9',
        // bssid: '00:00:00:00:00:00',
        password: passwordController.text,
      ));
    }

    ProvisioningResponse? response = await showDialog<ProvisioningResponse>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Provisioning'),
          content: const Text('Provisioning started. Please wait...'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Stop'),
            ),
          ],
        );
      },
    );

    if (provisioner.running) {
      provisioner.stop();
    }

    if (response != null) {
      _onDeviceProvisioned(response);
    }
  }

  _onDeviceProvisioned(ProvisioningResponse response) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Device provisioned'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Device successfully connected to the ${ssidController.text} network'),
              SizedBox.fromSize(size: const Size.fromHeight(20)),
              const Text('Device:'),
              Text('IP: ${response.ipAddressText}'),
              Text('BSSID: ${response.bssidText}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kPrimaryColor ,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cell_tower,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox.fromSize(size: const Size.fromHeight(20)),
              const Text(
                'Connect device to Wi-Fi network using ESP-Touch protocol',
                style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Pacifico'),
                textAlign: TextAlign.center,
              ),
              SizedBox.fromSize(size: const Size.fromHeight(40)),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'SSID (Network name)',
                  labelStyle: TextStyle(color: Colors.white)
                ),
                controller: ssidController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white)
                ),
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox.fromSize(size: const Size.fromHeight(40)),
              ElevatedButton(
                onPressed: _startProvisioning,
                child: const Text('Start provisioning'),
              ),
              SizedBox.fromSize(size: const Size.fromHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(width: 100,buttomText: 'Open',
                      onTap: () {_sendDataToESP32(0);}),
                  SizedBox(width: 70,),
                  CustomButton(width: 100,buttomText: 'Close',
                      onTap: () {_sendDataToESP32(1);}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToESP32( data) {
    // Create an instance of the Provisioner class
    final provisioner = Provisioner.espTouch();

    if (provisioner.running) {
      provisioner.start(ProvisioningRequest.fromStrings(
        ssid: ssidController.text,
        bssid: 'c4:de:e2:22:bf:b9',
        // bssid: '00:00:00:00:00:00',
        password: passwordController.text,
        reservedData: data.toString(),
      ));
    } else {
      showSnackBar(context, 'The provisioner is not running. Unable to send data to the ESP32 device.');
    }
  }

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}