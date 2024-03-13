import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'dart:io';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_1/pages/sales/testprint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/sales/thermalprint.dart';

bool regularprint = true;
bool thermalprint = false;
bool normalregularprint = true;
bool desingedregularprint = false;
BluetoothDevice? _device;

class Invoicesettings extends StatefulWidget {
  const Invoicesettings({Key? key}) : super(key: key);

  @override
  State<Invoicesettings> createState() => _InvoicesettingsState();
}

class _InvoicesettingsState extends State<Invoicesettings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                // icon: Icon(Icons.storage),
                text: 'Regular',
              ),
              Tab(
                // icon: Icon(Icons.add_box),
                text: 'Thermal',
              ),

              // Tab(
              //   icon: Icon(Icons.storage),
              //   text: 'Data Transfer',
              // ),
            ],
          ),
          title: const Text('Invoice Settings'),
        ),
        body: const TabBarView(
          children: [
            Regular(),
            Thermal(),
          ],
        ),
      ),
    );
  }
}

class Regular extends StatefulWidget {
  const Regular({Key? key}) : super(key: key);

  @override
  State<Regular> createState() => _RegularState();
}

class _RegularState extends State<Regular> {
  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? regularprint = prefs.getBool('regularprint');
    bool? normalregularprint = prefs.getBool('normalregularprint');
    bool? desingedregularprint = prefs.getBool('desingedregularprint');

    setState(() {
      if (prefs.getBool('regularprint') != null) {
        regularprint = regularprint;
      }
      if (prefs.getBool('normalregularprint') != null) {
        normalregularprint = normalregularprint;
      }
      if (prefs.getBool('desingedregularprint') != null) {
        desingedregularprint = desingedregularprint;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          SettingsItem(
            onTap: () {},
            icons: Icons.print,
            iconStyle: IconStyle(
              iconsColor: Colors.white,
              withBackground: true,
              backgroundColor: Colors.red,
            ),
            title: 'Make Regular printer Default',
            // subtitle: "Automatic",
            trailing: Switch.adaptive(
              value: regularprint,
              onChanged: (value) {
                if (value == false && _device == null) {
                  show('Please Select Thermal Printer');
                } else {
                  setState(() {
                    regularprint = value;
                    if (value == true) {
                      thermalprint = false;
                    } else {
                      thermalprint = true;
                    }
                  });
                  setregularprint(value);
                }
              },
            ),
          ),
          SettingsItem(
            onTap: () {},
            icons: Icons.print,
            iconStyle: IconStyle(
              iconsColor: Colors.white,
              withBackground: true,
              backgroundColor: Colors.red,
            ),
            title: 'Normal Invoice Print',
            // subtitle: "Automatic",
            trailing: Switch.adaptive(
              value: normalregularprint,
              onChanged: (value) {
                // print("desingedregularprint");
                setState(() {
                  normalregularprint = value;

                  if (value == true) {
                    desingedregularprint = false;
                  } else {
                    desingedregularprint = true;
                  }
                });
                setnormalregularprint(value);
              },
            ),
          ),
          SettingsItem(
            onTap: () {},
            icons: Icons.print,
            iconStyle: IconStyle(
              iconsColor: Colors.white,
              withBackground: true,
              backgroundColor: Colors.red,
            ),
            title: 'Designed Invoice Print',
            // subtitle: "Automatic",
            trailing: Switch.adaptive(
              value: desingedregularprint,
              onChanged: (value) {
                // print("normalregularprint");
                setState(() {
                  desingedregularprint = value;
                  if (value == true) {
                    normalregularprint = false;
                  } else {
                    normalregularprint = true;
                  }
                });
                setdesingedregularprint(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }

  Future<void> setregularprint(result) async {
    regularprint = result;
    final store = await SharedPreferences.getInstance();
    if (result == true) {
      store.setBool('thermalprint', false);
    } else {
      store.setBool('thermalprint', true);
    }
    store.setBool('regularprint', result);
  }

  Future<void> setdesingedregularprint(result) async {
    final store = await SharedPreferences.getInstance();

    if (result == true) {
      store.setBool('normalregularprint', false);
    } else {
      store.setBool('normalregularprint', true);
    }
    store.setBool('desingedregularprint', result);
  }

  Future<void> setnormalregularprint(result) async {
    final store = await SharedPreferences.getInstance();

    if (result == true) {
      store.setBool('desingedregularprint', false);
    } else {
      store.setBool('desingedregularprint', true);
    }
    store.setBool('normalregularprint', result);
  }
}

class Thermal extends StatefulWidget {
  const Thermal({Key? key}) : super(key: key);

  @override
  State<Thermal> createState() => _ThermalState();
}

class _ThermalState extends State<Thermal> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];

  bool _connected = false;
  String? pathImage;
  TestPrint? testPrint;

  @override
  void initState() {
    super.initState();
    _initCheck();
    initPlatformState();
    initSavetoPath();
    testPrint = TestPrint();
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? thermalprint = prefs.getBool('thermalprint');

    setState(() {
      if (prefs.getBool('thermalprint') != null) {
        thermalprint = thermalprint;
      }
    });
  }

  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    final filename = 'yourlogo.png';
    var bytes = await rootBundle.load("assets/images/yourlogo.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    setState(() {
      pathImage = '$dir/$filename';
    });
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // ignore: todo
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          SettingsItem(
            onTap: () {},
            icons: Icons.bluetooth,
            iconStyle: IconStyle(
              iconsColor: Colors.white,
              withBackground: true,
              backgroundColor: Colors.red,
            ),
            title: 'Make Regular Thermal Default',
            // subtitle: "Automatic",
            trailing: Switch.adaptive(
              value: thermalprint,
              onChanged: (value) {
                if (_device == null) {
                  show('No device selected.');
                } else {
                  setState(() {
                    thermalprint = value;
                    if (value == true) {
                      regularprint = false;
                    } else {
                      regularprint = true;
                    }
                  });
                  setthermalprint(value);
                }
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                'Device:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: DropdownButton(
                  items: _getDeviceItems(),
                  onChanged: (value) =>
                      setState(() => _device = value as BluetoothDevice?),
                  value: _device,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.brown),
                onPressed: () {
                  initPlatformState();
                },
                child: Text(
                  'Refresh',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: _connected ? Colors.red : Colors.green),
                onPressed: _connected ? _disconnect : _connect,
                child: Text(
                  _connected ? 'Disconnect' : 'Connect',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.brown),
              onPressed: () {
                testPrint?.sample([], pathImage!);
              },
              child: Text('PRINT TEST', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setthermalprint(result) async {
    final store = await SharedPreferences.getInstance();
    store.setBool('thermalprint', result);
    if (result == true) {
      store.setBool('regularprint', false);
    } else {
      store.setBool('regularprint', true);
    }
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name!),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
